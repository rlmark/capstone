class TalkingPoint < ActiveRecord::Base
  belongs_to :question

  validates :phrase, presence: true
end
