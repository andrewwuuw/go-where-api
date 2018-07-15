class CreateApplyForFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :apply_for_friends do |t|
      t.references :apply, foreign_key: { to_table: :users }
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
