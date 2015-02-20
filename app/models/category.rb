class Category < ActiveRecord::Base
  has_many :categoryquestions
  has_many :questions, :through => :categoryquestions
end
