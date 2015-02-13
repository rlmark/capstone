class Question < ActiveRecord::Base
  has_many :responses
  has_many :talking_points
  accepts_nested_attributes_for :talking_points

  validates :content, presence: true, length: {minimum: 3}

  def question_mark_check
    if self.content[-1] != "?"
      self.content += "?"
    end
  end
end
