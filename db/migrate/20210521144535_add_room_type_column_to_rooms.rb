class AddRoomTypeColumnToRooms < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :room_type, :string
  end
end
