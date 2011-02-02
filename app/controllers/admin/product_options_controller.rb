class Admin::ProductOptionsController < ApplicationController
  
  layout "admin"
  
  def new
    @product_option = ProductOption.new
  end

  def create
    @product_option = ProductOption.new(params[:product_option])
    
    respond_to do |format|
      if @product_option.save
        flash[:notice] = 'Nowa opcja zostala dodana.'
        format.html { redirect_to(edit_admin_product_path(@product_option.product)) }
      else
        format.html { redirect_to(edit_admin_product_path(@product_option.product)) }
      end
    end
  end

  def edit
    @product_option = ProductOption.find_by_id(params[:id])
  end

  def update
    @product_option = ProductOption.find_by_id(params[:id])    
    respond_to do |format|
      if @product_option.update_attributes(params[:product_option])
        flash[:notice] = 'Opcja zostala zmieniona.'
        format.html { redirect_to(admin_products_path) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def destroy
    @product_option = ProductOption.find_by_id(params[:id])
    @product_option.destroy
    
    respond_to do |format|
      format.html { redirect_to(admin_products_path) }
    end
  end
end
