class AddFromToExchangeRates < ActiveRecord::Migration
  def change
    add_column :exchange_rates, :from, :date
  end
end
