class ResponsesController < ApplicationController
  #before_action :question_created, only: [:new]

  def new
    @response = Response.new
  end

  def create
    @response = Response.new(response_params)
    @response.question_id = session[:question_id]
    if @response.save
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
