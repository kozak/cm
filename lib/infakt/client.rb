require "json"
require 'ostruct'
require 'pry'
require 'infakt/connection'
require 'active_support/core_ext/hash'

module Infakt
  class Client
    def all
      JSON.load(client_list)['clients'].map do |client|
        OpenStruct.new({
          :infakt_client_id => client['client_id'],
          :name => client['nazwa_firmy'],
          :nip => client['nip'],
          :street => client['ulica'],
          :city => client['miejscowosc'],
          :postcode => client['kod_pocztowy'],
          :country => client['panstwo']
        })
      end
    end

    private
    def client_list
      Connection.access_token.get('/api/v2/clients/list.json?per_page=100').body
    end
  end
end
