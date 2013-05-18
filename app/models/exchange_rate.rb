require 'nbp/currency'

class ExchangeRate < ActiveRecord::Base
  attr_accessible :currency, :date, :rate, :table, :from

  def self.get_rate(date, currency)
    raise ArgumentError.new("Invalid date") if date >= Date.today

    find_by_date(date) || begin
      nbp = Nbp::Currency.new(date, currency)
      create(
        :date     => date,
        :from     => date,
        :rate     => nbp.exchange_rate,
        :table    => nbp.table_name,
        :currency => currency
        )
    rescue Nbp::CantFindTable
      exchange_rate = get_rate(date-1, currency)
      create(
        :date     => date,
        :from     => exchange_rate.from,
        :rate     => exchange_rate.rate,
        :table    => exchange_rate.table,
        :currency => currency
        )
    rescue => e
      raise e unless e.message == 'getaddrinfo: nodename nor servname provided, or not known'

      new(
        :date => date,
        :from => date,
        :rate => nil,
        :table => nil,
        :currency => currency
      )
    end
  end

  def self.refresh!
    (90.days.ago.to_date..1.day.ago.to_date).each do |date|
      ExchangeRate.get_rate(date, 'EUR')
    end
  end
end
