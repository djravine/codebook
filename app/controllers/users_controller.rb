class UsersController < ApplicationController
  layout "blog"

  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  

  # GET /users
  # GET /users.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
		if simple_captcha_valid? 
	    success = @user && @user.save
	    if success && @user.errors.empty?
	      # Protects against session fixation attacks, causes request forgery
	      # protection if visitor resubmits an earlier form using back
	      # button. Uncomment if you understand the tradeoffs.
	      # reset session
	      self.current_user = @user # !! now logged in
	      redirect_back_or_default('/')
	      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
	    else
	      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
	      render :action => 'new'
	    end
		else
	    respond_to do |format|
	      flash[:notice] = 'Incorrect Captcha Code.'
				format.html { redirect_to "/users/new" }
			end
		end
  end




  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
    @roles = Role.find_all_by_user_id(params[:id])
    role = Role.new
    @usergroups = Usergroup.all

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end





  # GET /users/1/edit
  def edit
		auth = false
		if logged_in? && params[:id].to_s == @current_user.id.to_s
			auth = true
		end
		if admin?
			auth = true
		end
		if ! auth
			redirect_to("/")
		else
    	@user = User.find(params[:id])
		end
  end



  # PUT /users/1
  # PUT /users/1.xml
  def update
		auth = false
		if logged_in? && params[:id].to_s == @current_user.id.to_s
			auth = true
		end
		if admin?
			auth = true
		end
		if ! auth
			redirect_to("/")
		else
	    @user = User.find(params[:id])
	
	    respond_to do |format|
	      if @user.update_attributes(params[:user])
	        flash[:notice] = 'User was successfully updated.'
	        format.html { redirect_to(@user) }
	        format.xml  { head :ok }
	      else
	        format.html { render :action => "edit" }
	        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
	      end
	    end
		end
  end


end
