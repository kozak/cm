require "spec_helper"

describe 'root' do
  describe "routing" do
    it "routes to #index" do
      get("/").should route_to("invoices#index")
    end
  end
end
