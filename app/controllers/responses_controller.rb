class ResponsesController < ApplicationController
#  before_action :question_created, only: [:new, :create]

  def new
      @response = Response.new
    if params[:random]
      @question = Question.limit(1).order("RANDOM()")[0]
      session[:question_id] = @question.id
    else
      if session[:question_id] == nil
        redirect_to new_question_path
      else
        @question = Question.find(session[:question_id])
      end
    end
  end

  def create
    @response = Response.new(response_params)
    @response.question_id = session[:question_id]
    if @response.save
      session[:question_id] = nil
      Response.searchkick_index.refresh # Forces a reindex upon creation
      redirect_to results_path(response_id: @response.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def index
  end

  def show
  end

  private

  def response_params
    params.require(:response).permit(:transcript)
  end
end
