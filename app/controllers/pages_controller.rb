class PagesController < ApplicationController
  def show
    @page = params[:id].present? ? Page.find_by_permalink(params[:id]) : Page.home_page
    set_map if @page.is_a?(ContactPage)
    render :action => "show_#{@page.class.to_s.underscore}"
  end

  private
  def set_map
    @map = GoogleMap::Map.new
    @map.markers << GoogleMap::Marker.new(  :map => @map,
                                            :lat => 49.853677,
                                            :lng => 19.80472,
                                            :html => 'ROMI')
    @map.zoom = 12
    @map.language = "pl"
  end
end
