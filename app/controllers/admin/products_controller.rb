class Admin::ProductsController < ApplicationController

  layout "admin"

  def index
    @products = Product.all(:order => "created_at desc")
  end

  def show
    @product = Product.find_by_id(params[:id])
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find_by_id(params[:id])
  end

  def create
    @product = Product.new(params[:product])
    
    respond_to do |format|
      if @product.save
        flash[:notice] = 'Produkt został zapisany.'
        format.html { redirect_to(admin_products_path) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @product = Product.find_by_id(params[:id])
#    params[:product][:category_ids] ||= []    
    respond_to do |format|
      if @product.update_attributes(params[:product])
        flash[:notice] = 'Produkt został zaktualizowany.'
        format.html { redirect_to(admin_products_path) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @product = Product.find_by_id(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to(admin_products_path) }
    end
  end
end
