class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.integer :infakt_client_id
      t.string :name
      t.string :nip

      t.timestamps
    end
  end
end
