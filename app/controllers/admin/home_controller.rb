class Admin::HomeController < ApplicationController

  layout "admin"

  def index
  end

  def login
    render :layout => false
  end
end
