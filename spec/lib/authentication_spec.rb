require 'authentication'
require 'active_support/core_ext/object/blank'

describe Authentication do
  it "should require to be logged in" do
    ExampleController.should_receive(:before_filter).with(:login_required, :except => :login)
    ExampleController.send(:include, Authentication)
  end

  it "should not require to be logged in when model doesn't inherit from ActionController::Base" do
    FakeController = Struct.new(:fake_controller)
    FakeController.should_not_receive(:before_filter)
    FakeController.send(:include, Authentication)
  end

  context 'Controller' do
    subject { Controller.new }

    it "should redirect to login form when password is invalid" do
      subject.should_receive(:redirect_to).with(:login)
      subject.send :login_required
    end

    it "should give access when password is valid" do
      subject.should_not_receive(:redirect_to)
      subject.session[:password] = 'password'
      subject.send :login_required
    end

    it "should show login form" do
      subject.should_receive(:render).with(:login, :layout => false)
      subject.login
    end

    it "should set password and redirect to main page when provided" do
      password = stub
      subject.params[:password] = password
      subject.should_receive(:redirect_to).with(:root)
      subject.login
      subject.session[:password] = password
    end
  end

end

CONFIG = {'password' => 'password'}

module ActionController;
  class Base
    def self.before_filter(*args); end
  end
end

class ExampleController < ActionController::Base
end

class Controller < ActionController::Base
  include Authentication
  def session
    @session ||= Session.new
  end

  def params
    @params ||= Params.new
  end
end

class Hashable
  def initialize
    @hash = {}
  end
  def [](key)
    @hash[key]
  end
  def []=(key,value)
    @hash[key] = value
  end
end

class Session < Hashable; end
class Params  < Hashable; end
