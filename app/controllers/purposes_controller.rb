class PurposesController < ApplicationController
	layout "blog"

  # GET /purposes
  # GET /purposes.xml
  def index

    respond_to do |format|
      format.html # index.html.erb
      format.xml
    end
  end

end
