class Listing < ApplicationRecord 
  
  belongs_to :user
  # include BCrypt
end