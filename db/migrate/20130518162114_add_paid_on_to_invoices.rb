class AddPaidOnToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :paid_on, :date
  end
end
