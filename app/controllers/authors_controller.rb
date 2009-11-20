class AuthorsController < ApplicationController
	layout "blog"

  # GET /authors
  # GET /authors.xml
  def index

    respond_to do |format|
      format.html # index.html.erb
      format.xml
    end
  end

end
