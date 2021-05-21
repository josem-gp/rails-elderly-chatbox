class Room < ApplicationRecord
  TYPE = %w[public private]

  has_many :messages, dependent: :destroy
  has_many :users, through: :participants
  validates :name, presence: true
  validates :room, presence: true, inclusion: { in: TYPE }
end
