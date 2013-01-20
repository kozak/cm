require "json"
require 'ostruct'
require 'infakt/connection'
require 'active_support/core_ext/hash'

module Infakt
  class Invoice
    def all
      JSON.load(invoice_list)['invoices'].map do |invoice|
        OpenStruct.new({
          :number => invoice['numer'],
          :created_on => Date.parse(invoice['data_wystawienia']),
          :sold_on => Date.parse(invoice['data_sprzedazy']),
          :pay_on => Date.parse(invoice['termin_zaplaty']),
          :total_gross => invoice['razem_brutto'],
          :total_net => invoice['razem_netto'],
          :total_vat => invoice['razem_vat'],
          :currency => invoice['waluta'],
          :infakt_invoice_id => invoice['invoice_id'],
          :infakt_client_id => invoice['client_id'],
          :notice => invoice['uwagi']
        })
      end
    end

    def pdf(invoice_id, type)
      JSON.load(pdf_link(invoice_id, type))['pdf']
    end

    def create(invoice)
      create_invoice({
        'invoice' => {
          'status' => 'szkic', # wydrukowana
          'rodzaj_faktury' => 'Faktura VAT',
          'sposob_platnosci' => 'Przelew',
          'client_id' => invoice[:client_id],
          'data_wystawienia' => invoice[:created_on],
          'data_sprzedazy' => invoice[:created_on],
          'waluta' => invoice[:currency],
          'services' => [
            {
              'product_id' => invoice[:product_id],
              'nazwa' => invoice[:service_name],
              'ilosc' => 1,
              'stawka_vat' => 'np',
              'wartosc_netto' => invoice[:amount]
            }
          ],
          'podpis_sprzedawcy' => invoice[:seller],
          'uwagi' => invoice[:note]
        }
      })
    end

    private

    def create_invoice(params)
      Connection.access_token.post('/api/v2/invoices/create.json', params).body
    end

    def invoice_list
      Connection.access_token.get('/api/v2/invoices/list.json?per_page=100').body
    end

    def pdf_link(invoice_id, type)
      Connection.access_token.get("/api/v2/invoices/pdf.json?doc_type=#{type}&id=#{invoice_id}").body
    end
  end
end
