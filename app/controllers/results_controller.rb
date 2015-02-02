class ResultsController < ApplicationController
  def show
    @results = Response.search("test")
    @results = @results.response.hits.hits
  end
end
