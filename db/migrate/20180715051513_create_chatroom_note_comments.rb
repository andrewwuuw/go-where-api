class CreateChatroomNoteComments < ActiveRecord::Migration[5.2]
  def change
    create_table :chatroom_note_comments do |t|
      t.references :chatroom_note, foreign_key: true
      t.references :user, foreign_key: true
      t.string :content

      t.timestamps
    end
  end
end
