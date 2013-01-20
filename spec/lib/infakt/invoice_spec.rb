require 'infakt/invoice'

module Infakt
  describe Invoice do
    context 'list' do
      before do
        json = File.open(File.dirname(__FILE__) + "/../../fixtures/infakt/invoice_list.json").read
        subject.should_receive(:invoice_list).and_return(json)
      end

      it "should get list of invoices" do
        invoices = subject.all
        invoice = invoices.first
        invoice.number.should == '1/2011'
        invoice.created_on.should == Date.new(2012,3,30)
        invoice.sold_on.should == Date.new(2012,3,30)
        invoice.pay_on.should == Date.new(2012,4,13)
        invoice.infakt_client_id.should == 999999
        invoice.notice.should == 'VAT rozlicza nabywca - reverse charge'
        invoice.total_gross.should == 9999.0
        invoice.total_net.should == 9999.0
        invoice.total_vat.should == 0
        invoice.infakt_invoice_id.should == 123456
      end
    end

    context 'pdf' do
      before do
        json = File.open(File.dirname(__FILE__) + "/../../fixtures/infakt/pdf_link.json").read
        subject.should_receive(:pdf_link).and_return(json)
      end

      it "should get pdf url" do
        subject.pdf(2310190, "angpol").should == 'https://www.infakt.pl/files/pdfs/Company_GmbH_2012_03_30_9862_xxx.pdf'
      end
    end
  end
end
