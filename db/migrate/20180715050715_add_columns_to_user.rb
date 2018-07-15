class AddColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :authentication_token, :string
    add_column :users, :authentication_token_time, :datetime
    add_index :users, :authentication_token, unique: true

    add_column :users, :refresh_token, :string
    add_column :users, :refresh_token_time, :datetime
    add_index :users, :refresh_token, unique: true
  end
end
