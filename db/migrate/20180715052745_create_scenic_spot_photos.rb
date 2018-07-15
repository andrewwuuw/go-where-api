class CreateScenicSpotPhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :scenic_spot_photos do |t|
      t.references :scenic_spot, foreign_key: true
      t.string :path
      t.text :description

      t.timestamps
    end
  end
end
