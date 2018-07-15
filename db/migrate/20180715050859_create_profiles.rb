class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :nickname
      t.string :avatar
      t.string :phone
      t.integer :gender, default: 0
      t.text :description
      t.integer :device_type
      t.string :device_token
      t.boolean :is_public, default: true
      t.string :identifier
      t.index  :identifier, unique: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
