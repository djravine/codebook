class QuestionsController < ApplicationController
	layout "blog"

  # GET /questions
  # GET /questions.xml
  def index

    respond_to do |format|
      format.html # index.html.erb
      format.xml
    end
  end

end
