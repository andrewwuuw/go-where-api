class CreateChatrooms < ActiveRecord::Migration[5.2]
  def change
    create_table :chatrooms do |t|
      t.boolean :is_group, default: false
      t.string :name
      t.string :picture

      t.timestamps
    end
  end
end
