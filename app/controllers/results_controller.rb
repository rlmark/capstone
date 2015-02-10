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
    @results = @talking_points.collect do |point|
      Response.search( point.phrase,
        where: {id: @response.id},
        fields: [:transcript],
        highlight: true
      )
    end
    
    @filler_words = Result.search_filler_words(@response)

    @transcripts = Result.transcript_generator(@filler_words)
    # @transcripts = []
    # @filler_words.each do |word|
    #   word.with_details.each do |record, detail|
    #     @transcripts << detail[:highlight][:transcript]
    #   end
    # end
    #raise @transcripts.inspect

    @count = Result.filler_word_counter(@transcripts)
  end
end
