class ResultsController < ApplicationController
  before_action :interview_response_created

  def show
    # This is the preceding user input
    @response = Response.find(params[:response_id])
    # The original question prompt
    @question = Question.find(@response.question_id)
    # The points that the user would like to make in their speech
    @talking_points = @question.talking_points
    # Performs the elasticsearch NLP to see if talking_point was made
    @results = Result.search_talking_points(@talking_points, @response)

    @filler_words = Result.search_filler_words(@response)

    @highlighted_transcripts = Result.transcript_generator(@filler_words)

    @count = Result.filler_word_counter(@response.transcript)

  end
end
