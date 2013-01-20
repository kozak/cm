class AccountBalancesController < ApplicationController
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
    @account_balance = AccountBalance.find(params[:id])
  end

  def update
    @account_balance = AccountBalance.find(params[:id])
    if @account_balance.update_attributes(params[:account_balance])
      redirect_to [@account_balance.account.bank, @account_balance.account]
    else
      render :edit
    end
  end

  def show
  end
end
