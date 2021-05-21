class RenameAddressColumnInUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :address, :municipality
  end
end
