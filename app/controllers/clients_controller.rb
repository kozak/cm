class ClientsController < ApplicationController
  before_filter :find_client, :except => [:index, :refresh]

  def index
    @clients = Client.all
  end

  def update
    if @client.update_attributes(params[:client])
      redirect_to @client, notice: 'Client was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @client.destroy
    redirect_to clients_url
  end

  def refresh
    Client.import_from_infakt
    redirect_to :clients
  end

private
  def find_client
    @client = Client.find(params[:id])
  end
end
