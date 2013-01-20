require 'spec_helper'

describe DaysController do
  before do
    request.env["HTTP_REFERER"] ||= '/'
  end

  def valid_attributes
    { :date => '2012-12-12' }
  end

  describe "GET index" do
    it "assigns all days as @days" do
      day = Day.create! valid_attributes
      get :index, {}
      assigns(:days).should eq([day])
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "try to destroy day when exists" do
        day = stub
        day.should_receive(:destroy)
        Day.should_receive(:find_by_date).with('2012-12-12').and_return(day)
        put :update, {:id => '2012-12-12'}
      end

      it "should create new day when doesn't exists" do
        Day.should_receive(:find_by_date).with('2012-12-12').and_return(nil)
        expect {
          put :update, {:id => '2012-12-12'}
        }.to change(Day, :count).by(+1)
      end

      it "redirects back" do
        put :update, {:id => '1'}
        response.should redirect_to('/')
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested day" do
      day = Day.create! valid_attributes
      expect {
        delete :destroy, {:id => day.to_param}
      }.to change(Day, :count).by(-1)
    end

    it "redirects to the days list" do
      day = Day.create! valid_attributes
      delete :destroy, {:id => day.to_param}
      response.should redirect_to(days_url)
    end
  end
end
