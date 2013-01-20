class Mailer < ActionMailer::Base
  default from: CONFIG['email_settings']['user_name']

  def invoice(invoice)
    @invoice = invoice

    calendar = Calendar.new(invoice.created_on.to_s)
    @vacations = calendar.vacations
    @worked_days = calendar.worked_days

    pdf_name = "#{@invoice.number} #{@invoice.client} #{@invoice.created_on}".gsub(/\W/, '_')
    attachments["#{pdf_name}.pdf"] = open(Infakt::Invoice.new.pdf(@invoice.infakt_invoice_id, 'angpol')).read

    date = I18n.l(@invoice.created_on, :format => :calendar)
    mail(:to => CONFIG['email'], :subject => "#{CONFIG['name']} - Invoice #{date}")
  end
end
