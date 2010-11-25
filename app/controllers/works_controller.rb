class WorksController < ApplicationController
      def index
      	  @works = Work.all
      end

      def show
      	  @work = Work.find_by_id(params[:id])	  	  
	  render :text => "Nie znaleziono realizacji." unless @work
      end   
end