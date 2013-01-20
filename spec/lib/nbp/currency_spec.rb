require 'nbp/currency'

module Nbp
  describe Currency do
    subject { Currency.new(Date.new(2012,12,3), 'EUR') }

    before do
      tables = File.open(File.dirname(__FILE__) + "/../../fixtures/nbp/dir.txt").read
      subject.should_receive(:open).with(Currency::TABLE_URL).and_return(stub(read: tables))
    end

    context "exchange rate" do
      before do
        tables = File.open(File.dirname(__FILE__) + "/../../fixtures/nbp/a234z121203.xml").read
        subject.should_receive(:open).with(Currency::EXCHANGE_RATE_URL % 'a234z121203').and_return(stub(read: tables))
      end

      it "should get exchange rate for EUR" do
        subject.exchange_rate.should == 4.1083
      end
    end

    context "table" do
      it "should get NPB table for date" do
        subject.table.should == 'a234z121203'
      end

      it "should create valid table name" do
        subject.table_name.should == '234/A/NBP/2012'
      end

      it "should rise error when couldn't find NBP table" do
        subject.stub(:date).and_return(Date.new(2012,12,20))
        expect do
          subject.table
        end.to raise_error CantFindTable
      end
    end
  end
end
