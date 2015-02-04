class Question < ActiveRecord::Base
  has_many :responses
  has_many :talking_points

  validates :content, presence: true, length: { minimum: 5 }
end
