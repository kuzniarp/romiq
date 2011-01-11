# -*- coding: utf-8 -*-
class Admin::PagesController < ApplicationController

  layout "admin"

  def index
    @pages = Page.top_level_pages
  end

  def show
    @page = Page.find_by_permalink(params[:id])
  end

  def new
    @page = Page.new
    parent = Page.find_by_id(params[:parent_id])
    @default_order = parent ? parent.children.count : Page.top_level_pages.count
  end

  def edit
    @page = Page.find_by_permalink(params[:id])
  end

  def create
    page_class = params[:page][:type].constantize
    @page = page_class.new(params[:page])
    
    respond_to do |format|
      if @page.save
        flash[:notice] = 'Strona została zapisana.'
        format.html { redirect_to(admin_pages_path) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @page = Page.find_by_permalink(params[:id])
    
    respond_to do |format|
      if @page.update_attributes(params[:page])
        flash[:notice] = 'Strona została zaktualizowana'
        format.html { redirect_to(admin_pages_path) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @page = Page.find_by_permalink(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to(admin_pages_path) }
    end
  end

  def sort
    order = params[:page]
    Page.order(order)
    render :text => order.inspect
  end
end
