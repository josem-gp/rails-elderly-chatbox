class CreateShops < ActiveRecord::Migration[6.0]
  def change
    create_table :shops do |t|
      t.string :name
      t.string :address
      t.string :phone_number
      t.string :website
      t.string :images

      t.timestamps
    end
  end
end
