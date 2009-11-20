class Admin::DownloadsController < ApplicationController
	layout "blog"

  # GET /admin/downloads
  # GET /admin/downloads.xml
  def index
    @downloads = Download.find(:all, :conditions => {:parent_id => nil}, :order => 'created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @downloads }
    end
  end

  # GET /admin/downloads/1
  # GET /admin/downloads/1.xml
  def show
    @download = Download.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @download }
    end
  end

  # GET /admin/downloads/new
  # GET /admin/downloads/new.xml
  def new
    @download = Download.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @download }
    end
  end

  # GET /admin/downloads/1/edit
  def edit
    @download = Download.find(params[:id])
  end

  # POST /admin/downloads
  # POST /admin/downloads.xml
  def create
    @download = Download.new(params[:download])

    respond_to do |format|
      if @download.save
        flash[:notice] = 'Download was successfully created.'
        format.html { redirect_to(admin_downloads_url) }
        format.xml  { render :xml => @download, :status => :created, :location => @download }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @download.errors, :status => :unprocessable_entity }
      end
    end
  end


  # PUT /admin/downloads/1
  # PUT /admin/downloads/1.xml
  def update
    @download = Download.find(params[:id])

    respond_to do |format|
      if @download.update_attributes(params[:download])
        flash[:notice] = 'Download was successfully updated.'
        format.html { redirect_to(admin_downloads_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @download.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/downloads/1
  # DELETE /admin/downloads/1.xml
  def destroy
    @download = Download.find(params[:id])
    @download.destroy

    respond_to do |format|
      format.html { redirect_to(admin_downloads_url) }
      format.xml  { head :ok }
    end
  end



  def download
    @download = Download.find(params[:id])
    send_file("#{RAILS_ROOT}/public"+@download.public_filename, 
      :disposition => 'attachment',
      :encoding => 'utf8', 
      :type => @download.content_type,
      :filename => @download.filename) 
  end

end
