class DaysController < ApplicationController
  def index
    @days = Day.all
  end

  def update
    unless Day.find_by_date(params[:id]).try(:destroy)
      Day.new(:date => params[:id]).save
    end
    redirect_to :back
  end

  def destroy
    Day.find(params[:id]).destroy
    redirect_to days_url
  end
end
