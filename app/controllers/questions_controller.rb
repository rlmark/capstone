#require 'byebug'
class QuestionsController < ApplicationController
  def index
    @question_matches
  end

  def new
    @question = Question.new
    @talking_point = TalkingPoint.new
  end

  def create
    @question = Question.new(question_params)
    @question_matches = Question.search(@question.content,
    where: {private: false || nil},
    fields: [:content],
    highlight: true
    ).results
    if @question_matches.length >= 1
      redirect_to questions_path
    else
      if @question.save
        session[:question_id] = @question.id
        redirect_to new_talking_point_path
      else
        render :new
      end
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

  def question_params
    params.require(:question).permit(:content, :private)
  end
end
