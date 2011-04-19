class PostsController < ApplicationController
  
  def index
    @posts = Post.recent
	  @recent = Post.recent(params[:id])
  end
  
  def show
    @post = Post.find_by_id(params[:id])	  	  
	  @recent = Post.recent(params[:id])
	  render :text => "Nie znaleziono wpisu." unless @post
  end   
end
