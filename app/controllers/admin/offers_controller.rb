# -*- coding: utf-8 -*-
class Admin::OffersController < ApplicationController

  layout "admin"

  def index
    @offers = Offer.all(:order => "created_at desc")
  end

  def show
    @offer = Offer.find_by_id(params[:id])
  end

  def new
    @offer = Offer.new
  end

  def edit
    @offer = Offer.find_by_id(params[:id])
  end

  def create
    @offer = Offer.new(params[:offer])
    
    respond_to do |format|
      if @offer.save
        flash[:notice] = 'Promocja zostałs zapisana.'
        format.html { redirect_to(admin_offers_path) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @offer = Offer.find_by_id(params[:id])
    params[:offer] ||= {}
    params[:offer][:product_ids] ||= []
    params[:offer][:category_ids] ||= []
    respond_to do |format|
      if @offer.update_attributes(params[:offer])
        flash[:notice] = 'Promocja zostałs zaktualizowana.'
        format.html { redirect_to(admin_offers_path) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @offer = Offer.find_by_id(params[:id])
    @offer.destroy

    respond_to do |format|
      format.html { redirect_to(admin_offers_path) }
    end
  end
end
