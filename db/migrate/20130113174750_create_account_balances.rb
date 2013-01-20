class CreateAccountBalances < ActiveRecord::Migration
  def change
    create_table :account_balances do |t|
      t.integer :account_id
      t.date :created_on
      t.decimal :amount

      t.timestamps
    end
  end
end
