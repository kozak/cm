module Helpers
  def log_in
    ApplicationController.any_instance.stub(:login_required)
  end
end
