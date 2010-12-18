class WorksController < ApplicationController
      def index
      	  if params[:category_id]      	  
	     	@works = WorkCategory.find_by_permalink(params[:category_id]).works
	  else
		@works = Work.all(:order => "created_at desc", :limit => 5)
	  end
      end

      def show
      	  @work = Work.find_by_id(params[:id])	  	  
	  render :text => "Nie znaleziono realizacji." unless @work
      end   
end