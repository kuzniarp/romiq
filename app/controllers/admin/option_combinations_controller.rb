class Admin::OptionCombinationsController < ApplicationController
  layout "admin"
  
  def create
    @option_combination = OptionCombination.new(params[:option_combination])

    respond_to do |format|
      if @option_combination.save
        @product = @option_combination.product
        flash[:notice] = 'Nowa opcja zostala dodana.'
        format.js { render :partial => 'admin/products/option_combination_form' }
        format.html { redirect_to(edit_admin_product_path(@option_combination.product)) }
      else
        format.html { redirect_to(edit_admin_product_path(@option_combination.product)) }
      end
    end
  end

  def edit
    @option_combination = OptionCombination.find_by_id(params[:id])
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
    product = @option_combination.product
    @option_combination.destroy
    
    respond_to do |format|
      format.html { redirect_to(edit_admin_product_path(product)) }
    end
  end
end
