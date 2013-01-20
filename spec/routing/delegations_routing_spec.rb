require "spec_helper"

describe DelegationsController do
  describe "routing" do

    it "routes to #index" do
      get("/delegations").should route_to("delegations#index")
    end

    it "routes to #show" do
      get("/delegations/1").should route_to("delegations#show", :id => "1")
    end

    it "routes to #edit" do
      get("/delegations/1/edit").should route_to("delegations#edit", :id => "1")
    end

    it "routes to #create" do
      post("/delegations").should route_to("delegations#create")
    end

    it "routes to #update" do
      put("/delegations/1").should route_to("delegations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/delegations/1").should route_to("delegations#destroy", :id => "1")
    end
  end
end
