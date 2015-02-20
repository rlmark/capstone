#require 'byebug'
class QuestionsController < ApplicationController
  def index
    @categories = Category.all
    @questions = [] #Question.all
    @categoryquestion = Categoryquestion.new
  end

  def new
    @question = Question.new
    @talking_point = TalkingPoint.new
    @categories = Category.all
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
      associate_categories(question)
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
    @question_matches.inspect
  end

  # if a user takes the suggestion of preexisting question.
  def suggestion_taken
    session[:question_id] = params[:id]
    redirect_to new_talking_point_path
  end

  # if user says their question is indeed unique, this enters it in db and redirects
  def verified
    @question = Question.new(content: params[:verified], private: params[:private])
    save_and_redirect_the_unique(@question)
  end

  private

  def associate_categories(question)
    params[:question][:category_ids].each do |id|
      Categoryquestion.create(category_id: id, question_id: question.id)
    end
  end

  def question_params
    params.require(:question).permit(:content, :private)
  end

  def search_questions(content)
    @question_matches = Question.search( content,
    where: {private: false || nil},
    min_score: 0.4,
    fields: [:content],
    highlight: true,
    operator: "or"
    )

  end
end
