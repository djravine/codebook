class PostsController < ApplicationController
  layout "blog" 

  # GET /posts
  # GET /posts.xml
  def index

		# GET ALL THE BLOG POSTS
    @posts = Post.find(:all, :limit => 5)
    @downloads = Download.find(:all, :limit => 5, :conditions => {:parent_id => nil})

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/recent
  # GET /posts/recent.xml
  def recent

		# GET ALL THE RECENT POSTS
		@posts_recent = Post.find(:all, :limit => 5)

    respond_to do |format|
      format.html { render :layout => false } # recent.html.erb
      format.xml  { render :xml => @posts_recent }
    end
  end

  # GET /posts/popular
  # GET /posts/popular.xml
  def popular

		# GET ALL THE RECENT POSTS
		@posts_popular = Post.find(:all, :limit => 5, :order => "views DESC")

    respond_to do |format|
      format.html { render :layout => false } # popular.html.erb
      format.xml  { render :xml => @posts_popular }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
		Post.update_counters(params[:id], :views => 1)
    @post = Post.find(params[:id])
		@comments = Comment.find(:all, :conditions => { :post_id => params[:id] })
    @comment = Comment.new

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end
end