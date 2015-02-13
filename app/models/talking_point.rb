class TalkingPoint < ActiveRecord::Base
  belongs_to :question

  validates :phrase, presence: true, length: {minimum: 3}, allow_blank: false, :allow_nil => false
  # validates_presence_of :phrase

end
