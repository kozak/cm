class AccountBalancesController < ApplicationController
  before_filter :find_account_balance, :except => [:new, :create]
  def new
  end

  def create
    account_balances = params[:account_balances]
    date = account_balances.delete(:created_on).to_date rescue Date.today

    account_balances.each do |account_id, account_balance|
      AccountBalance.create(account_balance.merge(
        :created_on => date,
        :account_id => account_id))
    end

    redirect_to :banks
  end

  def edit
  end

  def update
    if @account_balance.update_attributes(params[:account_balance])
      redirect_to [@account_balance.account.bank, @account_balance.account]
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @account_balance.destroy
    redirect_to [@account_balance.account.bank, @account_balance.account]
  end

  private
  def find_account_balance
    @account_balance = AccountBalance.find(params[:id])
  end
end
