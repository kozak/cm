require 'open-uri'
require 'json'
require 'active_support/core_ext/hash'

module Nbp
  class Currency
    TABLE_URL         = "http://www.nbp.pl/Kursy/xml/dir.txt"
    EXCHANGE_RATE_URL = "http://www.nbp.pl/Kursy/xml/%s.xml"

    attr_reader :date, :currency

    def initialize(date, currency)
      @date     = date
      @currency = currency
    end

    def exchange_rate
      @exchange_rate ||= begin
        xml = open(EXCHANGE_RATE_URL % table).read.gsub('\"', '"')
        Hash.from_xml(xml)['tabela_kursow']['pozycja'].select do |rate|
          rate['kod_waluty'] == 'EUR'
        end.fetch(0)['kurs_sredni'].sub(',', '.').to_f
      end
    end

    def table
      @table ||= begin
        open(TABLE_URL).read[/a\d+z#{formated_date}/] || raise(CantFindTable.new("Can't find NBP table"))
      end
    end

    def table_name
      "#{table_number}/A/NBP/#{date.year}"
    end

    private
    def formated_date
      date.strftime("%y%m%d")
    end

    def table_number
      table[/\d+/]
    end
  end

  class CantFindTable < Exception
  end
end

