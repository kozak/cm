require "spec_helper"

describe DaysController do
  describe "routing" do

    it "routes to #index" do
      get("/days").should route_to("days#index")
    end

    it "routes to #update" do
      put("/days/1").should route_to("days#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/days/1").should route_to("days#destroy", :id => "1")
    end
  end
end
