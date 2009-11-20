class ArchievesController < ApplicationController
	layout "blog"

  # GET /archieves
  # GET /archieves.xml
  def index
    @posts = Post.find(:all, :limit => 30)
    @downloads = Download.find(:all, :limit => 30, :conditions => {:parent_id => nil})
		@datetoday=Date.today
		@_1lastmonth=@datetoday<<1
		@_2lastmonth=@datetoday<<2
		@_3lastmonth=@datetoday<<3
		@_4lastmonth=@datetoday<<4
		@_5lastmonth=@datetoday<<5


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /archieves/show/2009-11-2
  # GET /archieves/show/2009-11-2.xml
  def show
		@posts = Post.all
    @downloads = Download.find(:all, :conditions => {:parent_id => nil})
		@archieved_posts = Array.new
		@archieved_downloads = Array.new
		@archievedate = Date.strptime(params[:id], "%Y-%m-%d")
		@posts.each do |post|
			if post.created_at.strftime('%Y-%m-%d') == @archievedate.strftime('%Y-%m-%d')
				@archieved_posts << post
			end
		end
		@downloads.each do |download|
			if download.created_at.strftime('%Y-%m-%d') == @archievedate.strftime('%Y-%m-%d')
				@archieved_downloads << download
			end
		end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @archieved_posts }
    end
  end

  # GET /archieves/calander/0
  # GET /archieves/calander/0.xml
  def calander

    respond_to do |format|
      format.html { render :layout => false }# calander.html.erb
      format.xml  { render :xml => @tasks }
    end
  end

end
