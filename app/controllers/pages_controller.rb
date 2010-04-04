class PagesController < ApplicationController
  def show
    @page = params[:id].present? ? Page.find_by_permalink(params[:id]) : Page.home_page
    render :action => "show_#{@page.class.to_s.underscore}"
  end
end
