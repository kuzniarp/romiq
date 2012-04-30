class Admin::WorksController < ApplicationController
  layout "admin"
  # GET /works
  # GET /works.xml
  def index
    @works = Work.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @works }
    end
  end

  # GET /works/1
  # GET /works/1.xml
  def show
    @work = Work.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @work }
    end
  end

  # GET /works/new
  # GET /works/new.xml
  def new
    @work = Work.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @work }
    end
  end

  # GET /works/1/edit
  def edit
    @work = Work.find(params[:id])
  end

  # POST /works
  # POST /works.xml
  def create
    @work = Work.new(params[:work])

    respond_to do |format|
      if @work.save
        flash[:notice] = 'Work was successfully created.'
        format.html { redirect_to(admin_works_url) }
        format.xml  { render :xml => @work, :status => :created, :location => @work }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @work.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /works/1
  # PUT /works/1.xml
  def update
    @work = Work.find(params[:id])

    respond_to do |format|
      if @work.update_attributes(params[:work])
        flash[:notice] = 'Work was successfully updated.'
        format.html { redirect_to(admin_works_url) }
        format.js { render :text => '', :status => :ok }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.js { render :text => '', :status => :unprocessable_entity }
        format.xml  { render :xml => @work.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update_pictures
    success = false
    @work = Work.find_by_id(params[:id])
    begin
      @work.pictures.each{|picture| picture.data.reprocess!}    
      success = true
    rescue
    end
    respond_to do |format|
      if success
        format.js { render :text => '', :status => :ok }
      else
        format.js { render :text => '', :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /works/1
  # DELETE /works/1.xml
  def destroy
    @work = Work.find(params[:id])
    @work.destroy

    respond_to do |format|
      format.html { redirect_to(admin_works_url) }
      format.xml  { head :ok }
    end
  end
end
