class AddIndexToRatingsUserIdPhotoId < ActiveRecord::Migration[5.0]
  def change
    add_index :ratings, [:user_id, :photo_id], unique: true
  end
end
