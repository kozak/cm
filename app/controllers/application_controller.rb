require 'authentication'
require 'nbp/currency'
require 'calendar'

class ApplicationController < ActionController::Base
  include Authentication
  protect_from_forgery

end
