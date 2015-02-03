require 'byebug'
class ResultsController < ApplicationController
  def show
    # This is the preceding user input
    @response = Response.find(params[:response_id])
    # The original question prompt
    @question = Question.find(@response.question_id)
    # The points that the user would like to make in their speech
    @talking_points = @question.talking_points
    # Performs the elasticsearch NLP to see if talking_point was made
    @results = @talking_points.collect do |point|
      Response.search( point.phrase,
        where: {id: @response.id},
        fields: [:transcript],
        highlight: true
      )
    end

    @filler_words = ["like", "totally", "basically", "sorta", "sort of", "kinda", "kind of"].collect do |word|
      Response.search(word,
        where: {id: @response.id},
        fields: [:transcript],
        highlight: true
      )
    end
  end
end
