class RolesController < ApplicationController
  layout "blog"

  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  

  # GET /roles
  # GET /roles.xml
  def index
    @roles = Role.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @roles }
    end
  end

  # render new.rhtml
  def new
		if ! admin?
			redirect_to("/")
		else
    	@role = Role.new
    	@users = User.all
    	@usergroups = Usergroup.all
		end
  end
 
  def create
		if ! admin?
			redirect_to("/")
		else
	    @role = Role.new(params[:role])
	    respond_to do |format|
	      if @role.save
	        flash[:notice] = 'Role was successfully created.'
	        format.html { redirect_to "/roles" }
	        format.xml  { render :xml => @role, :status => :created, :location => @role }
	      else
	        format.html { render :action => "new" }
	        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
	      end
	    end
		end
  end



  # GET /roles/1
  # GET /roles/1.xml
  def show
    @role = Role.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @role }
    end
  end




  # DELETE /roles/1
  # DELETE /roles/1.xml
  def destroy
		if ! admin?
			redirect_to("/")
		else
	    @role = Role.find(params[:id])
	    @role.destroy
	
	    respond_to do |format|
	      format.html { redirect_to(roles_url) }
	      format.xml  { head :ok }
	    end
		end
  end


  # GET /roles/1/edit
  def edit
		if ! admin?
			redirect_to("/")
		else
    	@role = Role.find(params[:id])
    	@users = User.all
    	@usergroups = Usergroup.all
		end
  end



  # PUT /roles/1
  # PUT /roles/1.xml
  def update
		if ! admin?
			redirect_to("/")
		else
	    @role = Role.find(params[:id])
	
	    respond_to do |format|
	      if @role.update_attributes(params[:role])
	        flash[:notice] = 'Role was successfully updated.'
	        format.html { redirect_to "/roles" }
	        format.xml  { head :ok }
	      else
	        format.html { render :action => "edit" }
	        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
	      end
	    end
		end
  end


end
