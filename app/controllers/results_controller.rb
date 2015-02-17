class ResultsController < ApplicationController
  before_action :interview_response_created

  def show
    # This is the preceding user input
    @response = Response.find(session[:response_id])
    # The original question prompt
    @question = Question.find(@response.question_id)
    # The points that the user would like to make in their speech
    @talking_points = talking_point_objects
    # Performs elasticsearch to see if talking_point was made
    @results = Result.search_talking_points(@talking_points, @response)
    #raise @results.inspect

    ## limiting results by confidence score
    # @results.collect do |result|
    #   if result.response
    #
    # end

    @filler_words = Result.search_filler_words(@response)

    @highlighted_transcripts = Result.transcript_generator(@filler_words)

    @count = Result.filler_word_counter(@response.transcript)
    @sum = Result.total_filler_count(@count)
  end

  private

  def talking_point_objects
    session[:talking_points].collect do |id|
      TalkingPoint.find(id)
    end
  end
end
