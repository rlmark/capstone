# require 'elasticsearch/model'
class Response < ActiveRecord::Base
  belongs_to :question

  searchkick highlight: [:transcript]

  # only index the following column(s)
  def search_data
    as_json only: [:transcript]
  end

  Response.reindex
  # include Elasticsearch::Model
  # include Elasticsearch::Model::Callbacks

  # Class method which wraps elasticsearch's DSL
  # def self.search(query)
  #   __elasticsearch__.search(
  #   {
  #     query: {
  #       multi_match: {
  #         query: query,
  #         fields: ['transcript'] # add additional fields to index here
  #       }
  #     }
  #   }
  #   )
  # end
  #
  # # This makes use of elasticsearch's built in english analyzer (stemming etc.)
  # settings index: { number_of_shards: 1 } do
  #   mappings dynamic: 'false' do
  #     indexes :transcript, analyzer: 'english'
  #   end
  # end

end

# # In production, make this happen more intelligently (more spaced)? Just do once???? Maybe this is being done already. Could comment out.
#
# # Delete the previous response index in Elasticsearch
# Response.__elasticsearch__.client.indices.delete index: Response.index_name rescue nil
#
# # Create the new index with the new mapping
# Response.__elasticsearch__.client.indices.create \
# index: Response.index_name,
# body: { settings: Response.settings.to_hash, mappings: Response.mappings.to_hash }
#
# # Index all responce records from the DB to Elasticsearch
# Response.__elasticsearch__.import
