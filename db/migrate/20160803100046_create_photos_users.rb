class CreatePhotosUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :photos_users do |t|
      t.integer :photo_id
      t.integer :user_id
    end

    add_index :photos_users, [:photo_id, :user_id], unique: true
  end
end
