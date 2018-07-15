class CreateChatroomMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :chatroom_messages do |t|
      t.references :chatroom, foreign_key: true
      t.integer :message_type
      t.text :content
      t.integer :child
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
