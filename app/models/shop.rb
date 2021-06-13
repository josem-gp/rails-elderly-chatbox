class Shop < ApplicationRecord
  geocoded_by :address
  has_many :messages
  after_validation :geocode, if: :will_save_change_to_address?
  has_many_attached :photos

  include PgSearch::Model
  pg_search_scope :search_by_name_and_address,
    against: [ :name, :address ],
  using: {
    tsearch: { prefix: true }
  }
end
