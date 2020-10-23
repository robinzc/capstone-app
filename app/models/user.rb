class User < ApplicationRecord

  has_many :connections
  has_many :user_cities
  has_many :cities, through: :user_cities

end
