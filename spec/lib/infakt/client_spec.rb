require 'infakt/client'

module Infakt
  describe Client do
    before do
      json = File.open(File.dirname(__FILE__) + "/../../fixtures/infakt/client_list.json").read
      subject.should_receive(:client_list).and_return(json)
    end

    it "should get list of invoices" do
      client = subject.all.first

      client.name.should == 'Company GmbH'
      client.nip.should == 'DEXXXXXXXXX'
      client.infakt_client_id.should == 123456
    end
  end
end
