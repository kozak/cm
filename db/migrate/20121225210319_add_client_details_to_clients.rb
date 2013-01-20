class AddClientDetailsToClients < ActiveRecord::Migration
  def change
    add_column :clients, :street, :string
    add_column :clients, :city, :string
    add_column :clients, :postcode, :string
    add_column :clients, :country, :string
  end
end
