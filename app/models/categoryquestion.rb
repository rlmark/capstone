class Categoryquestion < ActiveRecord::Base
  belongs_to :categories
  belongs_to :questions
end
