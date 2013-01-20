module Authentication
  def self.included(base)
    if base < ActionController::Base
      base.before_filter :login_required, :except => :login
    end
  end

  def login
    if params[:password].present?
      session[:password] = params[:password]
      redirect_to :root
    else
      render :login, :layout => false
    end
  end

  def logout
    reset_session
    redirect_to :login
  end

  private
  def login_required
    unless session[:password] == CONFIG['password']
      redirect_to :login
    end
  end
end
