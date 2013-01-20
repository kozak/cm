class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string :number
      t.integer :infakt_invoice_id
      t.integer :infakt_client_id
      t.integer :exchange_rate_id
      t.decimal :total_gross
      t.decimal :total_net
      t.decimal :total_vat
      t.string :currency
      t.text :notice
      t.date :created_on
      t.date :sold_on
      t.date :pay_on

      t.timestamps
    end
  end
end
