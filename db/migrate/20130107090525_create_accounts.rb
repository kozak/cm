class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :bank_id
      t.string :name
      t.string :currency

      t.timestamps
    end
  end
end
