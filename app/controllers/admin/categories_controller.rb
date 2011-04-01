# -*- coding: utf-8 -*-
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
        format.html { redirect_to(admin_item_category_path(category_class)) }
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
        format.html { redirect_to(admin_item_category_path(@category.class))}
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

  def admin_item_category_path(model)
    case model.to_s 
    when 'ProductCategory' then admin_products_path
    when 'WorkCategory' then admin_works_path
    when 'FeatureCategory' then admin_products_path
    end
  end
end
