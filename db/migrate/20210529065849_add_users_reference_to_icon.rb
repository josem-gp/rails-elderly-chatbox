class AddUsersReferenceToIcon < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :icon, foreign_key: true
  end
end
