class ContactsController < ApplicationController
	layout "blog"

  # GET /contacts
  # GET /contacts.xml
  def index

    respond_to do |format|
      format.html # index.html.erb
      format.xml
    end
  end

end
