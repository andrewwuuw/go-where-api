class CreateScenicSpots < ActiveRecord::Migration[5.2]
  def change
    create_table :scenic_spots do |t|
      t.string :name
      t.string :description
      t.text :description_detail
      t.string :phone
      t.string :address
      t.string :open_time
      t.decimal :lat, precision: 10, scale: 7
      t.decimal :lng, precision: 10, scale: 7
      t.string :city
      t.text :travel_info

      t.timestamps
    end
  end
end
