class Day < ActiveRecord::Base
  attr_accessible :date

  validates :date, :presence => true

  def to_s
    date.to_s
  end

  def self.vacations(from, to)
    where("date >= ? AND date <= ?", from, to).inject({}) do |hash, day|
      hash.merge!({ day.date => true })
    end
  end
end
