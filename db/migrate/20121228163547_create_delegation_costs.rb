class CreateDelegationCosts < ActiveRecord::Migration
  def change
    create_table :delegation_costs do |t|
      t.integer :delegation_id
      t.string :name
      t.integer :number
      t.decimal :amount

      t.timestamps
    end
  end
end
