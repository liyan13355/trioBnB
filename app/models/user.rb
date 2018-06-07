require 'bcrypt'

class User < ApplicationRecord 
  include Clearance::User
  has_one :role
  include BCrypt
end
