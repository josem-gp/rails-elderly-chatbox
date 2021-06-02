class Event < ApplicationRecord
  belongs_to :room
  belongs_to :user
  validates :content, presence: true, length: { in: 5..300 }
end
