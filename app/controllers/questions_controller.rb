#require 'byebug'
class QuestionsController < ApplicationController
  def index
  end

  def new
    @question = Question.new
    @talking_point = TalkingPoint.new
  end

  def create
    @talking_point = TalkingPoint.new
    @question = Question.new(question_params)
    if @question.save
      talking_points.each do |point|
        TalkingPoint.create(phrase: point, question_id: @question.id)
      end
      session[:question_id] = @question.id
      redirect_to new_response_path
    else
      render :new
    end
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
    talking_points = params["question"]["talking_point"]["phrase"]
  end

  def question_params
    params.require(:question).permit(:content, :private)
  end
end
