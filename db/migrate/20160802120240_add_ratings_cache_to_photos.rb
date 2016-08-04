class AddRatingsCacheToPhotos < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :ratings_count, :integer, null: false, default: 0
    add_column :photos, :ratings_sum, :integer, null: false, default: 0
  end
end
