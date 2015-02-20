class Categoryquestion < ActiveRecord::Base
  belongs_to :category
  belongs_to :question
end
