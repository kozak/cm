class CreateDelegations < ActiveRecord::Migration
  def change
    create_table :delegations do |t|
      t.string :number
      t.datetime :started_at
      t.datetime :left_country_at
      t.datetime :returned_country_at
      t.datetime :ended_at
      t.integer :infakt_client_id
      t.string :border_city

      t.timestamps
    end
  end
end
