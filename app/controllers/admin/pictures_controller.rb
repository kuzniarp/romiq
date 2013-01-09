class Admin::PicturesController < ApplicationController
#  session :cookie_only => false, :only => :create
#  protect_from_forgery :except => :create
    
  def create
    if params[:Filedata]
      @picture = Picture.new      
      @picture.assetable_id = params[:assetable_id]
      @picture.assetable_type = params[:assetable_type]
      @picture.swfupload_file = params[:Filedata]
      if @picture.save
        render :partial => 'shared/picture', :object => @picture
      else
        render :text => @picture.errors.map{|e| e.join(' ').humanize}.join(' ')  
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

  def destroy
    @picture = Picture.find_by_id(params[:id])
    @picture.destroy
    render :nothing => true
  end
  
  def order
    order = params[:pictures_list]
    Picture.order(order)
    render :text => order.inspect
  end
end
