class TagsController < ApplicationController
	layout "blog"

  # GET /tags
  # GET /tags.xml
  def index
    @tags = Tag.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tags }
    end
  end

  # GET /tags/1
  # GET /tags/1.xml
  def show
    @posts = Post.all
    @downloads = Download.find(:all, :conditions => {:parent_id => nil})
		@tag_posts = Array.new
		@tag_downloads = Array.new
		@posts.each do |post|
			if post.tags != nil
				if post.tags.index(params[:id]) != nil
					@tag_posts << post
				end
			end
		end
		@downloads.each do |download|
			if download.tags != nil
				if download.tags.index(params[:id]) != nil
					@tag_downloads << download
				end
			end
		end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tag }
    end
  end

  # GET /tags/new
  # GET /tags/new.xml
  def new
    @tag = Tag.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tag }
    end
  end

  # GET /tags/1/edit
  def edit
    @tag = Tag.find(params[:id])
  end

  # POST /tags
  # POST /tags.xml
  def create
    @tag = Tag.new(params[:tag])

    respond_to do |format|
      if @tag.save
        flash[:notice] = 'Tag was successfully created.'
        format.html { redirect_to(@tag) }
        format.xml  { render :xml => @tag, :status => :created, :location => @tag }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tags/1
  # PUT /tags/1.xml
  def update
    @tag = Tag.find(params[:id])

    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        flash[:notice] = 'Tag was successfully updated.'
        format.html { redirect_to(@tag) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.xml
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to(tags_url) }
      format.xml  { head :ok }
    end
  end

  # GET /tags/list
  # GET /tags/list.xml
  def list
    @posts = Post.all
    @downloads = Download.all
		@tag_data = @posts | @downloads
		@tags = Array.new
		@tagssplit = Array.new
		@tag_data.each do |record|
			if record.tags != nil
				@tagssplit = record.tags.split(",")
				@tagssplit.each do |tag|
					newtagfound = 0
					temptagarray = Array.new
					@tags.each do |tagfound|
						if tagfound[0] == tag
							newtagfound = 1
							#debugger
							tagfound[1] = tagfound[1]+1
						end
					end
					if newtagfound == 0
						@tags << [ tag, 1 ]
					end
				end
			end
		end

    respond_to do |format|
      format.html { render :layout => false } # list.html.erb
      format.xml  { render :xml => @tag }
    end
  end
end
