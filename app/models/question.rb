class Question < ActiveRecord::Base
  has_many :responses
  has_many :talking_points
end
