class DownloadsController < ApplicationController
	layout "blog"

  # GET /downloads
  # GET /downloads.xml
  def index
    @downloads = Download.find(:all, :conditions => {:parent_id => nil}, :order => 'created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @downloads }
    end
  end

  # GET /downloads/1
  # GET /downloads/1.xml
  def show
		Download.update_counters(params[:id], :views => 1)
    @download = Download.find(params[:id])
		@comments = Comment.find(:all, :conditions => { :download_id => params[:id] })
    @comment = Comment.new

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @download }
    end
  end

  # GET /downloads/new
  # GET /downloads/new.xml
  def new
		if ! admin?
			redirect_to("/")
		else
	    @download = Download.new
	
	    respond_to do |format|
	      format.html # new.html.erb
	      format.xml  { render :xml => @download }
	    end
		end
  end

  # GET /downloads/1/edit
  def edit
		if ! admin?
			redirect_to("/")
		else
    	@download = Download.find(params[:id])
		end
  end

  # POST /downloads
  # POST /downloads.xml
  def create
		if ! admin?
			redirect_to("/")
		else
	    @download = Download.new(params[:download])
	
	    respond_to do |format|
	      if @download.save
	        flash[:notice] = 'Download was successfully created.'
	        format.html { redirect_to(@download) }
	        format.xml  { render :xml => @download, :status => :created, :location => @download }
	      else
	        format.html { render :action => "new" }
	        format.xml  { render :xml => @download.errors, :status => :unprocessable_entity }
	      end
	    end
		end
  end


  # PUT /downloads/1
  # PUT /downloads/1.xml
  def update
		if ! admin?
			redirect_to("/")
		else
	    @download = Download.find(params[:id])
	
	    respond_to do |format|
	      if @download.update_attributes(params[:download])
	        flash[:notice] = 'Download was successfully updated.'
	        format.html { redirect_to(@download) }
	        format.xml  { head :ok }
	      else
	        format.html { render :action => "edit" }
	        format.xml  { render :xml => @download.errors, :status => :unprocessable_entity }
	      end
	    end
		end
  end

  # DELETE /downloads/1
  # DELETE /downloads/1.xml
  def destroy
		if ! admin?
			redirect_to("/")
		else
	    @download = Download.find(params[:id])
	    @download.destroy
	
	    respond_to do |format|
	      format.html { redirect_to(downloads_url) }
	      format.xml  { head :ok }
	    end
		end
  end



  def download
		Download.update_counters(params[:id], :downloads => 1)
    @download = Download.find(params[:id])
    send_file("#{RAILS_ROOT}/public"+@download.public_filename, 
      :disposition => 'attachment',
      :encoding => 'utf8', 
      :type => @download.content_type,
      :filename => @download.filename) 
  end


  # GET /downloads/recent
  # GET /downloads/recent.xml
  def recent

		# GET ALL THE RECENT DOWNLOADS
		@downloads_recent = Download.find(:all, :limit => 5, :conditions => {:parent_id => nil})

    respond_to do |format|
      format.html { render :layout => false } # recent.html.erb
      format.xml  { render :xml => @downloads_recent }
    end
  end

  # GET /downloads/popular
  # GET /downloads/popular.xml
  def popular

		# GET ALL THE POPULAR DOWNLOADS
		@downloads_popular = Download.find(:all, :limit => 5, :order => "views DESC", :conditions => {:parent_id => nil})

    respond_to do |format|
      format.html { render :layout => false } # popular.html.erb
      format.xml  { render :xml => @downloads_popular }
    end
  end


end
