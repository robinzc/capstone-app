class User < ApplicationRecord

  has_secure_password
  validates :email, presence: true, uniqueness: true
  
  has_many :user_cities, dependent: :destroy
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

  # returns user obejcts based on connections
  def pending_friends
    friends = []
    connections.where(accepted: false).map do |connection|
      if self == connection.recipient
        friends << connection.sender
      end
    end
    friends
  end
# Array of people that sent me a friend request (so only I can accept)

  def accepted_friends
    friends = []
    connections.where(accepted: true).map do |connection|
      if self == connection.sender
        friends << connection.recipient
      else
        friends << connection.sender
      end
    end
    friends
  end

end
