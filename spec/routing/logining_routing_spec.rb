require "spec_helper"

describe 'Logining' do
  describe "routing" do

    it "routes to #login" do
      get("/login").should route_to("application#login")
      put("/login").should route_to("application#login")
    end

    it "routes to #login" do
      get("/logout").should route_to("application#logout")
    end
  end
end
