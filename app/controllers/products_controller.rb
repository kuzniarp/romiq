class ProductsController < ApplicationController
      
      def index
      	  @products = Product.all
      end

      def show
      	  @product = Product.find_by_id(params[:id])	  	  
	  render :text => "Nie znaleziono produktu." unless @product
      end   
end
