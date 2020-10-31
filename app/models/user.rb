class User < ApplicationRecord

  has_secure_password
  validates :email, presence: true, uniqueness: true
  
  has_many :user_cities
  has_many :cities, through: :user_cities

  def connections
    Connection.where("sender_id = ? OR recipient_id = ?", id, id)
  end

  def sender
    Connection.where("sender_id = ? AND accepted = ?", id, false)
  end

  def recipient
    Connection.where("recipient_id = ? AND accepted = ?", id, false)
  end

end
