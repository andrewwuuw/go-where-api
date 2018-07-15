class CreateChatroomNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :chatroom_notes do |t|
      t.references :chatroom, foreign_key: true
      t.references :user, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
