class TalkingPointsController < ApplicationController
  def index
  end

  def new
    @question = Question.find(session[:question_id])
    @talking_point = TalkingPoint.new
  end

  def create
    session[:talking_points] = []
    talking_points.each do |phrase|
      @talking_point = TalkingPoint.new(phrase: phrase, question_id: session[:question_id])
      if @talking_point.save
      session[:talking_points] << @talking_point.id
      end
    end
    redirect_to new_response_path
  end

  def show
  end

  def update
  end

  def destroy
  end

  def edit
  end

  private

  def talking_points
    talking_points = params["talking_point"]["phrase"]
  end
end
