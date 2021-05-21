class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates :content, presence: true, length: { in: 5..300 }
end
