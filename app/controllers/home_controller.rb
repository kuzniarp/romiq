class HomeController < ApplicationController
  def index
    redirect_to :controller => :pages, :action => :show, :id => nil
  end
end
