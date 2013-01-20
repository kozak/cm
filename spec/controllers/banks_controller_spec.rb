require 'spec_helper'

describe BanksController do

  def valid_attributes
    { :name => 'Bank name' }
  end

  describe "GET index" do
    it "assigns all banks as @banks" do
      bank = Bank.create! valid_attributes
      get :index, {}
      assigns(:banks).should eq([bank])
    end
  end

  describe "GET new" do
    it "assigns new bank as @bank" do
      get :new, {}
      assigns(:bank).should be_a_new(Bank)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Bank" do
        expect {
          post :create, {:bank => valid_attributes}
        }.to change(Bank, :count).by(1)
      end

      it "assigns a newly created bank as @bank" do
        post :create, {:bank => valid_attributes}
        assigns(:bank).should be_a(Bank)
        assigns(:bank).should be_persisted
      end

      it "redirects to the banks list" do
        post :create, {:bank => valid_attributes}
        response.should redirect_to(banks_url)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved bank as @bank" do
        Bank.any_instance.stub(:save).and_return(false)
        post :create, {:bank => { "name" => "" }}
        assigns(:bank).should be_a_new(Bank)
      end

      it "re-renders the 'new' template" do
        Bank.any_instance.stub(:save).and_return(false)
        post :create, {:bank => { "name" => "" }}
        response.should render_template("new")
      end
    end
  end

  describe "GET edit" do
    it "assigns the requested bank as @bank" do
      bank = Bank.create! valid_attributes
      get :edit, {:id => bank.to_param}
      assigns(:bank).should eq(bank)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested bank" do
        bank = Bank.create! valid_attributes
        Bank.any_instance.should_receive(:update_attributes).with({ "name" => "New Bank name" })
        put :update, {:id => bank.to_param, :bank => { "name" => "New Bank name" }}
      end

      it "assigns the requested bank as @bank" do
        bank = Bank.create! valid_attributes
        put :update, {:id => bank.to_param, :bank => valid_attributes}
        assigns(:bank).should eq(bank)
      end

      it "redirects to the bank" do
        bank = Bank.create! valid_attributes
        put :update, {:id => bank.to_param, :bank => valid_attributes}
        response.should redirect_to(banks_url)
      end
    end

    describe "with invalid params" do
      it "assigns the bank as @bank" do
        bank = Bank.create! valid_attributes
        Bank.any_instance.stub(:save).and_return(false)
        put :update, {:id => bank.to_param, :bank => { "name" => "" }}
        assigns(:bank).should eq(bank)
      end

      it "re-renders the 'edit' template" do
        bank = Bank.create! valid_attributes
        Bank.any_instance.stub(:save).and_return(false)
        put :update, {:id => bank.to_param, :bank => { "name" => "" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested bank" do
      bank = Bank.create! valid_attributes
      expect {
        delete :destroy, {:id => bank.to_param}
      }.to change(Bank, :count).by(-1)
    end

    it "redirects to the banks list" do
      bank = Bank.create! valid_attributes
      delete :destroy, {:id => bank.to_param}
      response.should redirect_to(banks_url)
    end
  end
end
