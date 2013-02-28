# encoding: utf-8

require 'infakt/invoice'

class Invoice < ActiveRecord::Base
  attr_accessible :infakt_client_id, :created_on, :notice, :number, :pay_on, :sold_on, :currency

  # Validations

  validates :number, :presence => true
  validates :pay_on, :presence => true
  validates :sold_on, :presence => true
  validates :created_on, :presence => true
  validates :currency, :presence => true
  validates :infakt_client_id, :presence => true

  has_one :client, :foreign_key => :infakt_client_id, :primary_key => :infakt_client_id

  before_save :calculate_gross_in_pln

  def self.import_from_infakt
    Infakt::Invoice.new.all.each do |infakt_invoice|
      find_or_create_by_infakt_invoice_id(infakt_invoice.infakt_invoice_id) do |invoice|
        [
          :number, :created_on, :sold_on, :pay_on,
          :total_vat, :infakt_client_id, :currency,
          :notice, :total_gross, :total_net, :pdf_url
        ].each do |attr|
          invoice.send("#{attr}=", infakt_invoice.send(attr))
        end
      end
    end
    true
  end

  def self.create_infakt_invoice(client_id = 944835, date = Date.today, worked_days = 1)
    Infakt::Invoice.new.create({
      :client_id => client_id,
      :created_on => date.to_s,
      :product_id => 502973,
      :service_name => 'Projektowanie stron internetowych / development services',
      :currency => 'EUR',
      :amount => worked_days * CONFIG['salary_per_day'],
      :seller => CONFIG['name'],
      :note => 'VAT rozlicza nabywca - "odwrotne obciążenie" - reverse charge'
    })
    import_from_infakt
    true
  end

  def exchange_rate
    ExchangeRate.get_rate(created_on-1, 'EUR')
  end

  private
  def calculate_gross_in_pln
    self.total_gross_in_pln =
      (currency == 'PLN' ? total_gross : total_gross * exchange_rate.rate).round(2)
  end
end
