class ResponsesController < ApplicationController
  def new
    @response = Response.new
  end

  def create
    @response = Response.new(response_params)
    if @response.save
      redirect_to new_response_path
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
    @responses
  end

  def show
  end

  private

  def response_params
    params.require(:response).permit(:transcript, :question_id)
  end
end
