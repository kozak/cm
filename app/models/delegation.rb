class Delegation < ActiveRecord::Base
  attr_accessible :number, :infakt_client_id, :ended_at, :left_country_at, :returned_country_at, :started_at, :border_city, :delegation_costs_attributes

  has_one :client, :foreign_key => :infakt_client_id, :primary_key => :infakt_client_id
  has_many :delegation_costs, :dependent => :destroy

  validates :number, :presence => true
  validates :infakt_client_id, :presence => true
  validates :ended_at, :presence => true
  validates :left_country_at, :presence => true
  validates :returned_country_at, :presence => true
  validates :started_at, :presence => true
  validates :border_city, :presence => true

  accepts_nested_attributes_for :delegation_costs, :reject_if => proc { |attrs| attrs.values.any?(&:blank?) }

  def self.next_number
    delegation = Delegation.last
    if delegation
      delegation.number.gsub(/^(\d)+/) {|i| i.to_i + 1 }
    else
      "1/#{Date.today.year}"
    end
  end

  def self.new_delegation
    delegation = Delegation.new
    delegation.number = Delegation.next_number
    delegation.border_city = 'Frankfurt'

    started = Time.now.beginning_of_week.change(:hour => 8, :min => 30)
    delegation.started_at = started.to_s(:long)
    delegation.left_country_at = (started + 1.5.hours).to_s(:long)

    ended = started + 2.days
    ended = Time.now if ended > Time.now
    ended = ended.change(:hour => 20, :min => 30)
    delegation.ended_at = ended.to_s(:long)
    delegation.returned_country_at = (ended - 1.5.hours).to_s(:long)

    delegation.delegation_costs.build(:name => 'Bilet metro', :amount => '1.40')
    delegation.delegation_costs.build(:name => 'Bilet metro', :amount => '2.40')

    3.times { delegation.delegation_costs.build }

    delegation
  end

  def days_number
    (ended_on - started_on).to_i + 1
  end

  def started_on
    started_at.to_date
  end

  def ended_on
    ended_at.to_date
  end

  def abroad_hours
    hours = (returned_country_at - left_country_at) / 1.hour
    hours.round(2)
  end

  def country_hours
    hours = (
      (left_country_at - started_at) +
      (ended_at - returned_country_at)
    ) / 1.hour
    hours.round(2)
  end

  def diet
    started_at >= '2013-03-01'.to_date ? 49 : 42
  end

  def diet_number
    quotient, modulus = abroad_hours.divmod(24)
    fraction = case
    when modulus > 12
      quotient += 1
      ""
    when modulus >= 8
      "1/2"
    when modulus > 0
      "1/3"
    end
    "#{quotient} #{fraction}"
  end

  def diet_total
    quotient, modulus = abroad_hours.divmod(24)
    case
    when modulus > 12
      (quotient + 1) * diet
    when modulus >= 8
      ((quotient*2+1)*diet)/2
    when modulus > 0
      ((quotient*3+1)*diet)/3
    end
  end

  def costs_total
    diet_total + delegation_costs.sum(&:total_amount)
  end

  def costs_total_in_pln
    costs_total * exchange_rate.rate
  end

  def exchange_rate
    @delegation_exchange_rate ||= ExchangeRate.get_rate(ended_on - 1, 'EUR')
  end
end
