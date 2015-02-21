require 'bcrypt'

class User < ActiveRecord::Base
  has_many :userquestions
  has_many :questions, through: :userquestions
  has_secure_password
end
