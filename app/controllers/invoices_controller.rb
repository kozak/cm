class InvoicesController < ApplicationController
  before_filter :find_invoice, :except => [:index, :new, :create, :refresh]
  def index
    @invoices = Invoice.order('created_on desc, number desc').includes(:client)
  end

  def create
    if valid_invoice?
      create_invoice
      send_invoice
      redirect_to :invoices, notice: 'Invoice was successfully created.'
    else
      flash.now[:error] = 'All fields are required'
      render :new
    end
  end

  def update
    if @invoice.update_attributes(params[:invoice])
      redirect_to @invoice, notice: 'Invoice was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @invoice.destroy
    redirect_to invoices_url
  end

  def refresh
    Invoice.import_from_infakt
    redirect_to :invoices
  end

  def rate
    if @invoice.paid_on.nil?
      redirect_to @invoice, :notice => 'Paid on is empty'
    else
      render :pdf => 'rate.pdf', :layout => false, :formats => [:pdf]
    end
  end

  def pdf
    redirect_to Infakt::Invoice.new.pdf(@invoice.infakt_invoice_id, 'angpol')
  end

  private

  def find_invoice
    @invoice = Invoice.find(params[:id])
  end

  def invoice
    params[:invoice]
  end

  def valid_invoice?
    [
      invoice,
      invoice[:client_id],
      invoice[:date]
    ].all?(&:present?) && (invoice[:date].to_date <= Date.today rescue false)
  end

  def create_invoice
    date = invoice[:date].to_date
    worked_days = Calendar.new(date.to_s).worked_days.size
    Invoice.create_infakt_invoice(invoice[:client_id].to_i, date, worked_days)
  end

  def send_invoice
    Mailer.invoice(Invoice.last).deliver
  end
end
