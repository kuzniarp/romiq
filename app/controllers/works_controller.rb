class WorksController < ApplicationController
  def index
    if params[:category_id]      	  
      @category = WorkCategory.find_by_permalink(params[:category_id])
      @works = @category ? Work.for_categories(@category.all_children).paginate(:page => params[:page]) : []
	  else
      @works = Work.paginate(:page => params[:page], :order => "created_at desc")
	  end
  end
  
  def show
    @work = Work.find_by_id(params[:id])	  	  
	  render :text => "Nie znaleziono realizacji." unless @work
  end   
end
