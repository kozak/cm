class AccountsController < ApplicationController
  before_filter :find_bank
  before_filter :find_account, :except => [:new, :create]

  def new
    @account = @bank.accounts.build
  end

  def create
    @account = @bank.accounts.build(params[:account])
    if @account.save
      redirect_to :banks, notice: 'Account was successfully created.'
    else
      render :new
    end
  end

  def update
    if @account.update_attributes(params[:account])
      redirect_to :banks, notice: 'Account was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @bank.destroy
    redirect_to :banks, notice: 'Account was successfully destroyed.'
  end

  private
  def find_bank
    @bank = Bank.find(params[:bank_id])
  end

  def find_account
    @account = @bank.accounts.find(params[:id])
  end
end
