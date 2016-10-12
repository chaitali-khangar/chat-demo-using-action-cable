class User < ApplicationRecord
  has_many :messages
  has_one :chatroom, through: :messages

  validates :username, presence: true, uniqueness: true
end
