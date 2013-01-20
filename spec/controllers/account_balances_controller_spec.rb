require 'spec_helper'

describe AccountBalancesController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  context "with account balance" do
    before(:all) do
      @account_balance = AccountBalance.create(
        :account_id => 1,
        :amount => 100,
        :created_on => Date.today)
    end

    describe "GET 'edit'" do
      it "returns http success" do
        get 'edit', :id => @account_balance.id
        response.should be_success
      end

      it "assigns account_balance" do
        get 'edit', :id => @account_balance.id
        assigns(:account_balance).should == @account_balance
      end
    end

    describe "GET 'show'" do
      it "returns http success" do
        get 'show', :id => @account_balance.id
        response.should be_success
      end
    end
  end
end
