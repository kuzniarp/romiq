class OffersController < ApplicationController
  def index
    #if params[:category_id]      	  
    #  @category = OfferCategory.find_by_permalink(params[:category_id])
    #  @offers = @category ? @category.all_children.map{|c| c.offers}.flatten : []
	  #else
      @offers = Offer.all(:order => "created_at desc")
	  #end
  end
  
  def show
    @offer = Offer.find_by_id(params[:id])
	  render :text => "Nie znaleziono promocji." unless @offer
  end   
end
