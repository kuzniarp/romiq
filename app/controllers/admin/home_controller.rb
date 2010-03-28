class Admin::HomeController < ApplicationController

  layout "admin", :except => :login

  before_filter :admin_required, :except => :login

  def index
  end

  def login
    if request.post?
      if User.authenticate params[:login], params[:password]
        session[:user_id] = true
        redirect_to admin_root_path
      else
        flash[:login_notice] = "Niepoprawne dane logowania."
      end
    end
  end

  def logout
    session[:user_id] = false
    redirect_to admin_login_path
  end
  
  def admin_required
    redirect_to admin_login_path unless session[:user_id]
  end
end
