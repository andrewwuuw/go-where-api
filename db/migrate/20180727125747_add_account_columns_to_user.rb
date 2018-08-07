class AddAccountColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :device_type, :integer
    add_column :users, :device_token, :string
    add_column :users, :is_public, :boolean, default: true
    add_column :users, :identifier, :string
  end
end
