class AddTotalGrossInPlnToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :total_gross_in_pln, :decimal
  end
end
