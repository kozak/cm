class ExchangeRatesController < ApplicationController
  before_filter :find_exchange_rate, :except => :index
  def index
    @exchange_rates = ExchangeRate.order('date desc')
  end

  def update
    if @exchange_rate.update_attributes(params[:exchange_rate])
      redirect_to @exchange_rate, notice: 'Exchange rate was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @exchange_rate.destroy
    redirect_to exchange_rates_url
  end

  private
  def find_exchange_rate
    @exchange_rate = ExchangeRate.find(params[:id])
  end
end
