require 'spec_helper'

describe ExchangeRatesController do
  def valid_attributes
    { "rate" => "9.99" }
  end

  describe "GET index" do
    it "assigns all exchange_rates as @exchange_rates" do
      exchange_rate = ExchangeRate.create! valid_attributes
      get :index, {}
      assigns(:exchange_rates).should eq([exchange_rate])
    end
  end

  describe "GET show" do
    it "assigns the requested exchange_rate as @exchange_rate" do
      exchange_rate = ExchangeRate.create! valid_attributes
      get :show, {:id => exchange_rate.to_param}
      assigns(:exchange_rate).should eq(exchange_rate)
    end
  end

  describe "GET edit" do
    it "assigns the requested exchange_rate as @exchange_rate" do
      exchange_rate = ExchangeRate.create! valid_attributes
      get :edit, {:id => exchange_rate.to_param}
      assigns(:exchange_rate).should eq(exchange_rate)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested exchange_rate" do
        exchange_rate = ExchangeRate.create! valid_attributes
        ExchangeRate.any_instance.should_receive(:update_attributes).with({ "rate" => "9.99" })
        put :update, {:id => exchange_rate.to_param, :exchange_rate => { "rate" => "9.99" }}
      end

      it "assigns the requested exchange_rate as @exchange_rate" do
        exchange_rate = ExchangeRate.create! valid_attributes
        put :update, {:id => exchange_rate.to_param, :exchange_rate => valid_attributes}
        assigns(:exchange_rate).should eq(exchange_rate)
      end

      it "redirects to the exchange_rate" do
        exchange_rate = ExchangeRate.create! valid_attributes
        put :update, {:id => exchange_rate.to_param, :exchange_rate => valid_attributes}
        response.should redirect_to(exchange_rate)
      end
    end

    describe "with invalid params" do
      it "assigns the exchange_rate as @exchange_rate" do
        exchange_rate = ExchangeRate.create! valid_attributes
        ExchangeRate.any_instance.stub(:save).and_return(false)
        put :update, {:id => exchange_rate.to_param, :exchange_rate => { "rate" => "invalid value" }}
        assigns(:exchange_rate).should eq(exchange_rate)
      end

      it "re-renders the 'edit' template" do
        exchange_rate = ExchangeRate.create! valid_attributes
        ExchangeRate.any_instance.stub(:save).and_return(false)
        put :update, {:id => exchange_rate.to_param, :exchange_rate => { "rate" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested exchange_rate" do
      exchange_rate = ExchangeRate.create! valid_attributes
      expect {
        delete :destroy, {:id => exchange_rate.to_param}
      }.to change(ExchangeRate, :count).by(-1)
    end

    it "redirects to the exchange_rates list" do
      exchange_rate = ExchangeRate.create! valid_attributes
      delete :destroy, {:id => exchange_rate.to_param}
      response.should redirect_to(exchange_rates_url)
    end
  end
end
