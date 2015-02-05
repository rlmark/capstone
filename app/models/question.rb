class Question < ActiveRecord::Base
  has_many :responses
  has_many :talking_points
  accepts_nested_attributes_for :talking_points

  validates :content, presence: true, length: { minimum: 5 }
end
