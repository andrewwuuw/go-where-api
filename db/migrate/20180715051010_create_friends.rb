class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      t.references :friend, foreign_key: { to_table: :users }
      t.references :user, foreign_key: true
      t.string :nickname

      t.timestamps
    end
  end
end
