class Admin::PicturesController < ApplicationController
#  session :cookie_only => false, :only => :create
#  protect_from_forgery :except => :create
    
  def create
    if params[:Filedata]
      @picture = Picture.new(:swfupload_file => params[:Filedata])
      @picture.assetable_id = params[:assetable_id]
      @picture.assetable_type = params[:assetable_type]
      if @picture.save
        render :partial => 'admin/works/picture', :object => @picture
      else
        render :text => "error"
      end
    else
      @picture = Picture.new params[:picture]
      if @picture.save
        flash[:notice] = 'Your picture has been uploaded!'
        redirect_to admin_works_path
      else
        render :action => :new
      end
    end
  end
end
