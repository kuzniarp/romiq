class Admin::OptionsController < ApplicationController
  
  layout "admin"
  
  def new
    @option = Option.new
  end

  def create
    @option = Option.new(params[:option])
    
    respond_to do |format|
      if @option.save
        flash[:notice] = 'Nowa opcja zostala dodana.'
        format.html { redirect_to(admin_products_path) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def edit
    @option = Option.find_by_id(params[:id])
  end

  def update
    @option = Option.find_by_id(params[:id])    
    respond_to do |format|
      if @option.update_attributes(params[:option])
        flash[:notice] = 'Opcja zostala zmieniona.'
        format.html { redirect_to(admin_products_path) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def destroy
    @option = Option.find_by_id(params[:id])
    @option.destroy
    
    respond_to do |format|
      format.html { redirect_to(admin_products_path) }
    end
  end

  def for_feature
    if params[:feature_id].present?
      feature = Feature.find_by_id(params[:feature_id])
#      @product = Product.find_by_id(params[:product_id])
      @options = feature.options
      render :partial => '/admin/products/option_combination_form_options'
    else
      render :nothing => true
    end
  end
end
