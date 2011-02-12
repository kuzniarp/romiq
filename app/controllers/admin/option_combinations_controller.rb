class Admin::OptionCombinationsController < ApplicationController
  layout "admin"
  
  def new
    @product = Product.find_by_id(params[:product_id])
    @option_combination = OptionCombination.new
    @option_combination.product = @product
    respond_to do |format|
      format.js { render :partial => 'admin/products/option_combination_form' }
    end
  end
  
  def create
    @option_combination = OptionCombination.new(params[:option_combination])

    respond_to do |format|
      if @option_combination.save
        @product = @option_combination.product
        flash[:notice] = 'Nowa kombinacja zostala zapisana.'
        format.js { render :partial => 'admin/products/option_combination_form' }
        format.html { redirect_to(edit_admin_product_path(@option_combination.product)) }
      else
        format.html { redirect_to(edit_admin_product_path(@option_combination.product)) }
      end
    end
  end

  def edit
    @option_combination = OptionCombination.find_by_id(params[:id])
    @product = @option_combination.product
    respond_to do |format|
      format.js { render :partial => 'admin/products/option_combination_form' }
    end
  end

  def update
    @option_combination = OptionCombination.find_by_id(params[:id])    
    respond_to do |format|
      if @option_combination.update_attributes(params[:option_combination])
        @product = @option_combination.product
        flash[:notice] = 'Kombinacja zostala zmieniona.'
        format.js { render :partial => 'admin/products/option_combination_form' }
        format.html { redirect_to(edit_admin_product_path(@option_combination.product)) }
      else
        format.html { redirect_to(edit_admin_product_path(@option_combination.product)) }
      end
    end
  end

  def destroy
    @option_combination = OptionCombination.find_by_id(params[:id])
    @product = @option_combination.product
    @option_combination.destroy
    @option_combination = nil
    respond_to do |format|
      format.js { render :partial => 'admin/products/option_combination_form' }
      format.html { redirect_to(edit_admin_product_path(@product)) }
    end
  end
end
