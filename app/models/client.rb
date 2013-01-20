require 'infakt/client'

class Client < ActiveRecord::Base
  attr_accessible :infakt_client_id, :name, :nip, :street, :city, :postcode, :country

  validates :name, :presence => true
  validates :nip, :presence => true

  def to_s
    name
  end

  def self.import_from_infakt
    Infakt::Client.new.all.each do |infakt_client|
      find_or_create_by_infakt_client_id(infakt_client.infakt_client_id) do |client|
        [
          :name, :nip, :infakt_client_id, :street, :city, :postcode, :country
        ].each do |attr|
          client.send("#{attr}=", infakt_client.send(attr))
        end
      end
    end

    true
  end

  def self.select_options
    all.map do |client|
      [client, client.infakt_client_id]
    end
  end
end
