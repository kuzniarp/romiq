class ProductsController < ApplicationController  
  def index
    if params[:category_id]      	  
      @category = ProductCategory.find_by_permalink(params[:category_id])
      @products = @category ? Product.for_categories(@category.all_children).paginate(:page => params[:page]) : []
	  else
      @products = Product.paginate(:page => params[:page], :order => "created_at desc")
	  end
  end
  
  def show
    @product = Product.find_by_id(params[:id])	  	  
	  render :text => "Nie znaleziono produktu." unless @product
  end   

  def pictures_for_options    
    @product = Product.find_by_id(params[:product_id])
    option_ids = params[:options].reject{|o| o.blank?}.map{|o| o.to_i}.sort
    if option_ids.present?
      photos = @product.option_combinations.select{|oc| option_ids.all?{|optid| oc.options.map(&:id).include?(optid)} }.map{|oc| oc.pictures}.flatten.uniq
    else
      photos = @product.pictures
    end
    render :partial => "photos", :locals => {:photos => photos}
  end
end
