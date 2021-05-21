class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :users, through: :participants
  validates :name, presence: true
end
