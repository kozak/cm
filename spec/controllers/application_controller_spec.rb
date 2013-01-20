require 'spec_helper'

describe ApplicationController do
  it "should include authentication" do
    subject.should respond_to(:login)
    subject.should respond_to(:logout)
    subject.should respond_to(:login_required)
  end
end
