require 'spec_helper'

describe ClientsController do
  def valid_attributes
    {
      "name" => 'Name',
      "nip" => 'PL12312312',
      "infakt_client_id" => "1"
    }
  end

  describe "GET index" do
    it "assigns all clients as @clients" do
      client = Client.create! valid_attributes
      get :index, {}
      assigns(:clients).should eq([client])
    end
  end

  describe "GET show" do
    it "assigns the requested client as @client" do
      client = Client.create! valid_attributes
      get :show, {:id => client.to_param}
      assigns(:client).should eq(client)
    end
  end

  describe "GET edit" do
    it "assigns the requested client as @client" do
      client = Client.create! valid_attributes
      get :edit, {:id => client.to_param}
      assigns(:client).should eq(client)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested client" do
        client = Client.create! valid_attributes
        Client.any_instance.should_receive(:update_attributes).with({ "infakt_client_id" => "1" })
        put :update, {:id => client.to_param, :client => { "infakt_client_id" => "1" }}
      end

      it "assigns the requested client as @client" do
        client = Client.create! valid_attributes
        put :update, {:id => client.to_param, :client => valid_attributes}
        assigns(:client).should eq(client)
      end

      it "redirects to the client" do
        client = Client.create! valid_attributes
        put :update, {:id => client.to_param, :client => valid_attributes}
        response.should redirect_to(client)
      end
    end

    describe "with invalid params" do
      it "assigns the client as @client" do
        client = Client.create! valid_attributes
        Client.any_instance.stub(:save).and_return(false)
        put :update, {:id => client.to_param, :client => { "infakt_client_id" => "invalid value" }}
        assigns(:client).should eq(client)
      end

      it "re-renders the 'edit' template" do
        client = Client.create! valid_attributes
        Client.any_instance.stub(:save).and_return(false)
        put :update, {:id => client.to_param, :client => { "infakt_client_id" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end

  describe "GET refresh" do
    it "refreshes clients from infakt" do
      Client.should_receive(:import_from_infakt)
      get :refresh
      response.should redirect_to(clients_path)
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested client" do
      client = Client.create! valid_attributes
      expect {
        delete :destroy, {:id => client.to_param}
      }.to change(Client, :count).by(-1)
    end

    it "redirects to the clients list" do
      client = Client.create! valid_attributes
      delete :destroy, {:id => client.to_param}
      response.should redirect_to(clients_url)
    end
  end
end
