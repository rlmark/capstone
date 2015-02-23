class TalkingPoint < ActiveRecord::Base
  belongs_to :question

  validates :phrase, presence: true, length: {minimum: 3}, on: :create 

end
