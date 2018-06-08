require 'bcrypt'

class User < ApplicationRecord 
  include Clearance::User
  has_one :role
  has_many :listings
  # include BCrypt
end
