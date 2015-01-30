class QuestionsController < ApplicationController
  def index
  end

  def new
    @question = Question.new
    @talking_point = TalkingPoint.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      talking_points.each do |point|
        TalkingPoint.create(phrase: point, question_id: @question.id)
      end
      redirect_to new_response_path(question_id: @question.id)
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
    talking_points = params["talking_point"]["phrase"]
  end

  def question_params
    params.require(:question).permit(:content, :private)
  end
end
