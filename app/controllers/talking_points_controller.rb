class TalkingPointsController < ApplicationController
  def index
  end

  def new
    @talking_point = TalkingPoint.new
    if params[:random]
      # gathering a random question for interview mode where public is enabled
      questions = Question.where("
not exists(select 1 from categoryquestions where categoryquestions.question_id = questions.id)
or exists(select 1 from categoryquestions where categoryquestions.question_id = questions.id and categoryquestions.category_id = 51)").where(private: false)
      @question = questions.sample
      session[:question_id] = @question.id
    else
      @question = Question.find(session[:question_id])
    end
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
