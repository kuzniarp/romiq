class HomeController < ApplicationController
  skip_before_filter :authenticate, :only => :login
  def index
    redirect_to :controller => :pages, :action => :show, :id => nil
  end

  def login
    if request.post?
      if params[:login]== "romiq" && params[:password] == "beta"
        session[:authenticated] = true 
        redirect_to root_path and return
      else
        flash[:notice] = "Niepoprawny login/haslo"
      end
    end
    render :layout => false
  end
end
