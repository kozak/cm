class BanksController < ApplicationController
  before_filter :find_bank, :except => [:index, :new, :create]

  def index
    @banks = Bank.all
  end

  def new
    @bank = Bank.new
  end

  def create
    @bank = Bank.new(params[:bank])
    if @bank.save
      redirect_to :banks, notice: 'Bank was successfully created.'
    else
      render :new
    end
  end

  def update
    if @bank.update_attributes(params[:bank])
      redirect_to :banks, notice: 'Bank was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @bank.destroy
    redirect_to :banks, notice: 'Bank was successfully destroyed.'
  end

  private
  def find_bank
    @bank = Bank.find(params[:id])
  end
end
