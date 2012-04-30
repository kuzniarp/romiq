# -*- coding: utf-8 -*-
class Admin::ProductsController < ApplicationController

  layout "admin"

  def index
    @products = Product.all(:order => "created_at desc")
    @features = Feature.all
  end

  def show
    @product = Product.find_by_id(params[:id])
  end

  def new
    @product = Product.new
  end

  def clone
    origin = Product.find_by_id(params[:id])
    @product = origin.clone
    @product.name = origin.name + ' kopia'
#     combinations = []
#     origin.option_combinations.each do |orig_comb|
#       pictures = []
#       new_comb = orig_comb.clone
#       new_comb.product_id = @product.id
#       orig_comb.option_combination_pictures.each do |orig_pict|
#         new_pict = orig_pict.clone
#         new_pict.option_combination_id = new_comb.id
#         pictures << new_pict
#       end
#       new_comb.option_combination_pictures = pictures
#       combinations << new_comb
#     end
#     @product.option_combinations = combinations
#    categories = origin.category_items.map{|c| c.clone}
#    categories.each{|c| c.item_id = @product.id}
    @product.categories = origin.categories.clone
    render :action => 'new'
  end

  def edit
    @product = Product.find_by_id(params[:id])
    @features = Feature.all
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
        format.js { render :text => '', :status => :ok }
      else
        format.html { render :action => "edit" }
        format.js { render :text => '', :status => :unprocessable_entity }
      end
    end
  end

  def update_pictures
    success = false
    @product = Product.find_by_id(params[:id])
    begin
      @product.pictures.each{|picture| picture.data.reprocess!}    
      success = true
    rescue
    end
    respond_to do |format|
      if success
        format.js { render :text => '', :status => :ok }
      else
        format.js { render :text => '', :status => :unprocessable_entity }
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
