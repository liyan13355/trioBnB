class Listing < ApplicationRecord 
  belongs_to :user 
  enum verified: [:true, :false]
end