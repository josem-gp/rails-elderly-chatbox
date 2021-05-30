class AddMessagesReferenceToShop < ActiveRecord::Migration[6.0]
  def change
    add_reference :messages, :shop, foreign_key: true
  end
end
