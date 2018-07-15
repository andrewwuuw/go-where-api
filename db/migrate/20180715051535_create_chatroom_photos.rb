class CreateChatroomPhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :chatroom_photos do |t|
      t.references :chatroom, foreign_key: true
      t.string :path

      t.timestamps
    end
  end
end
