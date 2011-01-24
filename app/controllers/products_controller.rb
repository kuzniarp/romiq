class ProductsController < ApplicationController  
  def index
    if params[:category_id]      	  
      @category = ProductCategory.find_by_permalink(params[:category_id])
      @products = @category ? @category.products : [] #all_children.map{|c| c.products}.flatten
	  else
      @products = Product.all(:order => "created_at desc", :limit => 5)
	  end
  end
  
  def show
    @product = Product.find_by_id(params[:id])	  	  
	  render :text => "Nie znaleziono produktu." unless @product
  end   
end
