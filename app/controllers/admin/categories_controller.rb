class Admin::CategoriesController < ApplicationController

  layout "admin"

  def index
     
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find_by_permalink(params[:id])
  end

  def create
    category_class = params[:category][:type].constantize
    @category = category_class.new(params[:category])
    
    respond_to do |format|
      if @category.save
        flash[:notice] = 'Strona została zapisana.'
        format.html { redirect_to(category_class == ProductCategory ? admin_products_path : admin_work_path) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @category = Category.find_by_permalink(params[:id])
    
    respond_to do |format|
      if @category.update_attributes(params[:category])
        flash[:notice] = 'Kategoria została zaktualizowana'
        format.html { redirect_to(@category.class == ProductCategory ? admin_products_path : admin_works_path) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @category = Category.find_by_permalink(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to(admin_products_path) }
    end
  end

  def sort
    order = params[:category]
    Category.order(order)
    render :text => order.inspect
  end
end
