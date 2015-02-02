require 'elasticsearch/model'
class Response < ActiveRecord::Base
  belongs_to :question

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

end

Response.import

@responses = Response.search('medicine').records
