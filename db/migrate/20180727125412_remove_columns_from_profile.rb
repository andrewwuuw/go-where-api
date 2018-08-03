class RemoveColumnsFromProfile < ActiveRecord::Migration[5.2]
  def change
    remove_column :profiles, :device_type
    remove_column :profiles, :device_token
    remove_column :profiles, :is_public
    remove_column :profiles, :identifier
  end
end
