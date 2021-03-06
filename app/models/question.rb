class Question < ActiveRecord::Base
  has_many :responses
  has_many :talking_points
  has_many :categoryquestions
  has_many :categories, through: :categoryquestions
  has_many :userquestions
  has_many :users, :through => :userquestions

  accepts_nested_attributes_for :talking_points
  accepts_nested_attributes_for :categories

  validates :content, presence: true, length: {minimum: 3}
  # validates :categoryquestions, presence: true
  # validates :categories, presence: true

  searchkick highlight: [:content]

  def search_data
    as_json only: [:content]
  end

  Question.reindex

end
