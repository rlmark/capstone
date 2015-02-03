class ResultsController < ApplicationController
  def show

    analysis = Response.search("this is testing")
    @results = analysis.results
  end
end
