#require 'byebug'
class QuestionsController < ApplicationController
  def index
    @question = Question.find(params[:id])
    search_questions(@question.content)
  end

  def new
    @question = Question.new
    @talking_point = TalkingPoint.new
  end

  def create
    @question = Question.new(question_params)
    search_questions(@question.content)
    # @question_matches is an instance var gen by search_questions function below
    if @question_matches.results.length >= 1
      redirect_to suggest_questions_path(original_question: @question.content, private: @question.private)
    else
      save_and_redirect_the_unique(@question)
    end
  end

  # Part of the create method
  def save_and_redirect_the_unique(question)
    if question.save
      session[:question_id] = question.id
      redirect_to new_talking_point_path
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

  # When a new question is entered, but similar questions already exist, go here
  def suggest
    search_questions(params[:original_question])
  end

  def suggestion_taken
    session[:question_id] = params[:id]
    redirect_to new_talking_point_path
  end

  def verified
    @question = Question.new(content: params[:verified], private: params[:private])
    save_and_redirect_the_unique(@question)
  end

  private

  def question_params
    params.require(:question).permit(:content, :private)
  end

  def search_questions(content)
    @question_matches = Question.search(content,
    where: {private: false || nil},
    fields: [:content],
    highlight: true
    )
  end
end
