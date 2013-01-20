class CreateExchangeRates < ActiveRecord::Migration
  def change
    create_table :exchange_rates do |t|
      t.decimal :rate
      t.string :currency
      t.date :date
      t.string :table

      t.timestamps
    end
  end
end
