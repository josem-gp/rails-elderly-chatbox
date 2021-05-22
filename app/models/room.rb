class Room < ApplicationRecord
  TYPE = %w[public private]

  has_many :messages, dependent: :destroy
  has_many :users, through: :participants
  validates :name, presence: true, uniqueness: true
  validates :room_type, presence: true, inclusion: { in: TYPE }
end
