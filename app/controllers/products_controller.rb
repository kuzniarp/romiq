class ProductsController < ApplicationController
  before_filter :set_current_view_parameters, :only => [:index]
  def index
    if params[:category_id]      	  
      @category = ProductCategory.find_by_permalink(params[:category_id])
      @products = @category ? Product.for_categories(@category.all_children).paginate(:page => params[:page], :per_page => @per_page, :order => @order) : []
	  else
      @products = Product.paginate(:page => params[:page], :per_page => @per_page, :order => @order)
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

  def change_view
    cookies[:products_index_view] = params[:view] if Product::ALLOWED_VIEWS.keys.include?(params[:view])
    redirect_to :params => params.merge(:action => :index, :view => nil)
  end

  def change_order
    cookies[:products_index_order] = params[:order] if Product::ALLOWED_ORDERS.keys.include?(params[:order])
    redirect_to :params => params.merge(:action => :index, :order => nil)
  end

  protected

  def set_current_view_parameters
    set_current_view
    set_current_order
    @per_page = Product::ALLOWED_VIEWS[@current_view]
    @order = Product::ALLOWED_ORDERS[@current_order]
  end

  def set_current_view
    current_view = cookies[:products_index_view]
    @current_view = current_view.present? && Product::ALLOWED_VIEWS.keys.include?(current_view) ? current_view : 'long_view' 
  end

  def set_current_order
    current_order = cookies[:products_index_order]
    @current_order = current_order.present? && Product::ALLOWED_ORDERS.keys.include?(current_order) ? current_order : 'date' 
  end
end
