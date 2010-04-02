# -*- coding: utf-8 -*-
class Admin::PagesController < ApplicationController

  layout "admin"

  def index
    @pages = Page.all
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new
  end

  def edit
    @page = Page.find(params[:id])
  end

  def create
    @page = Page.new(params[:page])

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
    @page = Page.find(params[:id])

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
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to(admin_pages_path) }
    end
  end
end
