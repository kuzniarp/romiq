class ProductsController < ApplicationController
      
      def index
      	  if params[:category_id]      	  
	     	@products = ProductCategory.find_by_permalink(params[:category_id]).products
	  else
		@products = Product.all
	  end
      end

      def show
      	  @product = Product.find_by_id(params[:id])	  	  
	  render :text => "Nie znaleziono produktu." unless @product
      end   
end
