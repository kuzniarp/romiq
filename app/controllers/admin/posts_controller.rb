class Admin::PostsController < ApplicationController

  layout "admin"

  def index
    @posts = Post.all(:order => "created_at desc")
  end

  def show
    @post = Post.find_by_id(params[:id])
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find_by_id(params[:id])
  end

  def create
    @post = Post.new(params[:post])
    
    respond_to do |format|
      if @post.save
        flash[:notice] = 'Post został zapisany.'
        format.html { redirect_to(admin_posts_path) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @post = Post.find_by_id(params[:id])
    
    respond_to do |format|
      if @post.update_attributes(params[:post])
        flash[:notice] = 'Post został zaktualizowany.'
        format.html { redirect_to(admin_posts_path) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @post = Post.find_by_id(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(admin_posts_path) }
    end
  end
end
