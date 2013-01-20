class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.string :type
      t.date :date

      t.timestamps
    end

    add_index :days, :date
  end
end
