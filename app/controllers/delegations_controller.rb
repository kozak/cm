class DelegationsController < ApplicationController
  before_filter :find_delegation, :except => [:index, :new, :create]

  def index
    @delegations = Delegation.includes(:client).order('started_at desc')
  end

  def new
    @delegation = Delegation.new_delegation
  end

  def create
    @delegation = Delegation.new(params[:delegation])
    if @delegation.save
      redirect_to @delegation
    else
      render :new
    end
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => pdf_filename, :layout => false
      end
    end
  end

  def edit
    @delegation.delegation_costs.build
  end

  def update
    if @delegation.update_attributes(params[:delegation])
      redirect_to @delegation
    else
      render :edit
    end
  end

  def destroy
    @delegation.destroy
    redirect_to :delegations
  end

  private
  def find_delegation
    @delegation = Delegation.find(params[:id])
  end

  def pdf_filename
    [
      @delegation.number,
      @delegation.client,
      @delegation.started_at.to_date
    ].join('_').gsub(/\W/, '_')
  end
end
