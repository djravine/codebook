class CommentsController < ApplicationController
  layout "blog"

  # POST /comments
  # POST /comments.xml
  def create
    @comment = Comment.new(params[:comment])

   if simple_captcha_valid?  
    respond_to do |format|#
      if @comment.save
        flash[:notice] = 'Comment was successfully posted.'
        format.html { redirect_to :back }
        format.xml  { render :xml => @comment, :status => :created, :location => :back }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
   else  
    respond_to do |format|#
      flash[:notice] = 'Incorrect Captcha Code.'
		  format.html { redirect_to :back }
    end
   end 
  end





  # GET /comments/recent
  # GET /comments/recent.xml
  def recent

		# GET ALL THE RECENT POSTS
		@comments_recent = Comment.find(:all, :limit => 5)

    respond_to do |format|
      format.html { render :layout => false } # recent.html.erb
      format.xml  { render :xml => @comments_recent }
    end
  end





end