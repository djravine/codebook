# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
	layout "blog"
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem

  # render admin.html.erb
  def admin
    respond_to do |format|
      format.html { render :layout => false } # admin.html.erb
		end
  end


  # render mod.html.erb
  def mod
    respond_to do |format|
      format.html { render :layout => false } # mod.html.erb
		end
  end


  # render info.html.erb
  def info
    respond_to do |format|
      format.html { render :layout => false } # info.html.erb
		end
  end


  # render new.html.erb
  def new
	  session[:original_uri] = request.request_uri
    respond_to do |format|
      format.html { render :layout => false } # new.html.erb
		end
  end

  def create
    logout_keeping_session!
    user = User.authenticate(params[:login], params[:password])
    if user
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      self.current_user = user
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
		  uri = session[:original_uri]
		  session[:original_uri] = nil
		  if uri
		    redirect_to uri
		  else
		    redirect_back_or_default('/')
		  end
      flash[:notice] = "Logged in successfully"
    else
      note_failed_signin
    	flash[:notice] = note_failed_signin
      @login       = params[:login]
      @remember_me = params[:remember_me]
		  uri = session[:original_uri]
		  session[:original_uri] = nil
		  if uri
		    redirect_to uri
		  else
		    redirect_back_or_default('/')
		  end
    end
  end

  def destroy
    logout_killing_session!
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end

protected
  # Track failed login attempts
  def note_failed_signin
    flash[:error] = "Couldn't log you in as '#{params[:login]}'"
    logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
end
