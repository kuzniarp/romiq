class Admin::FeaturesController < ApplicationController

  layout "admin"

  def new
    @feature = Feature.new
  end

  def create
    feature_class = params[:feature][:type].constantize
    @feature = feature_class.new(params[:feature])
    
    respond_to do |format|
      if @feature.save
        flash[:notice] = 'Nowa cecha zostala dodana.'
        format.html { redirect_to(admin_products_path) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def edit
    @feature = Feature.find_by_id(params[:id])
  end
  
  def update
    @feature = Feature.find_by_id(params[:id])    
    @feature.attributes = params[:feature]
    @feature.type = params[:feature][:type]
    respond_to do |format|
      if @feature.save
        flash[:notice] = 'Cecha zostala zmieniona.'
        format.html { redirect_to(admin_products_path) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def destroy
    @feature = Feature.find_by_id(params[:id])
    @feature.destroy
    
    respond_to do |format|
      format.html { redirect_to(admin_products_path) }
    end
  end  

  def for_category
    if params[:category_id].present?
      category = FeatureCategory.find_by_id(params[:category_id])
      @features = category.features
      render :partial => '/admin/products/features_form', :locals => {:product_id => params[:product_id]}
    else
      render :nothing => true
    end
  end
end
