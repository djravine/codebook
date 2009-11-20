class Admin::PostsController < ApplicationController
  layout "blog"

  # GET /admin/posts
  # GET /admin/posts.xml
  def index
		if ! admin?
			redirect_to("/")
		else

			# GET ALL THE BLOG POSTS
	    @posts = Post.all

	    respond_to do |format|
	      format.html # index.html.erb
	      format.xml  { render :xml => @posts }
	    end
		end
  end

  # GET /admin/posts/recent
  # GET /admin/posts/recent.xml
  def recent

		if ! admin?
			redirect_to("/")
		else
			# GET ALL THE RECENT POSTS
			@posts_recent = Post.find(:all, :limit => 10)
	
	    respond_to do |format|
	      format.html { render :layout => false } # recent.html.erb
	      format.xml  { render :xml => @posts_recent }
	    end
		end
  end

  # GET /admin/posts/popular
  # GET /admin/posts/popular.xml
  def popular
		if ! admin?
			redirect_to("/")
		else

			# GET ALL THE RECENT POSTS
			@posts_popular = Post.find(:all, :limit => 10)
	
	    respond_to do |format|
	      format.html { render :layout => false } # popular.html.erb
	      format.xml  { render :xml => @posts_popular }
	    end
		end
  end

  # GET /admin/posts/1
  # GET /admin/posts/1.xml
  def show
		if ! admin?
			redirect_to("/")
		else
	    @post = Post.find(params[:id])
			@comments = Comment.find(:all, :conditions => { :post_id => params[:id] })
	    @comment = Comment.new
	
	    respond_to do |format|
	      format.html # show.html.erb
	      format.xml  { render :xml => @post }
	    end
		end
	end

  # GET /admin/posts/1/edit
  # GET /admin/posts/1/edit.xml
  def edit
		if ! admin?
			redirect_to("/")
		else
	    @post = Post.find(params[:id])
	
	    respond_to do |format|
	      format.html # edit.html.erb
	      format.xml  { render :xml => @post }
	    end
		end
	end


  # GET /admin/posts/1
  # GET /admin/posts/1.xml
  def update
		if ! admin?
			redirect_to("/")
		else
	    @post = Post.find(params[:id])
	
	    respond_to do |format|
	      if @post.update_attributes(params[:post])
	        flash[:notice] = 'Post was successfully updated.'
	        format.html { redirect_to(@post) }
	        format.xml  { head :ok }
	      else
	        format.html { render :action => "edit" }
	        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
	      end
	    end
		end
	end


  # GET /admin/posts/1
  # GET /admin/posts/1.xml
  def new
		if ! admin?
			redirect_to("/")
		else
	    @post = Post.new
	
	    respond_to do |format|
	      format.html # new.html.erb
	      format.xml  { render :xml => @post }
	    end
		end
	end


  # GET /admin/posts/1
  # GET /admin/posts/1.xml
  def create
		if ! admin?
			redirect_to("/")
		else
	    @post = Post.new(params[:post])
	
	    respond_to do |format|
	      if @post.save
	        flash[:notice] = 'Post was successfully created.'
	        format.html { redirect_to(@post) }
	        format.xml  { render :xml => @post, :status => :created, :location => @post }
	      else
	        format.html { render :action => "new" }
	        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
	      end
	    end
		end
	end


  # DELETE /admin/posts/1
  # DELETE /admin/posts/1.xml
  def destroy
		if ! admin?
			redirect_to("/")
		else
	    @post = Post.find(params[:id])
	    @post.destroy
	
	    respond_to do |format|
	      format.html { redirect_to(posts_url) }
	      format.xml  { head :ok }
	    end
		end
  end


end
