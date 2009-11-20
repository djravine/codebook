# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  protect_from_forgery # See ActionController::RequestForgeryProtection for details

	before_filter :fetch_logged_in_user

  protected


  def fetch_logged_in_user
	  return unless session[:user_id]
	  @current_user = User.find_by_id(session[:user_id])
	  @current_role = Role.find_all_by_user_id(session[:user_id])
  end

  def logged_in?
		! @current_user.nil?
  end
  helper_method :logged_in?

  def admin?
		return_string = false
		if logged_in?
			if ! @current_role.nil?
				@current_role.each do |role|
					if role.name == "administrator"
						return_string = true 
					end
				end
			end
		end
		return return_string
  end
  helper_method :admin?

  def mod?
		return_string = false
		if logged_in?
			if ! @current_role.nil?
				@current_role.each do |role|
					if role.name == "moderator"
						return_string = true 
					end
				end
			end
		end
		return return_string
  end
  helper_method :mod?

  def clearance
		if logged_in?
		  return @current_user.clearance
		else
		  return nil
		end
  end
  helper_method :clearance

  def login_required
		return true if logged_in?
		session[:return_to] = request.request_uri
		flash[:notice]="You have to log in!"
		redirect_to :controller => 'logins', :action => 'login' and return false
  end

  def ip_address
		return request.remote_ip
  end

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

	include SimpleCaptcha::ControllerHelpers 
end

