class RemoveIconReferenceToUsers < ActiveRecord::Migration[6.0]
  def change
    remove_reference :icons, :user, foreign_key: true
  end
end
