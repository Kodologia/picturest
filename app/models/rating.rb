class Rating < ApplicationRecord
  after_save :update_photo_ratings_sum

  validates :value, inclusion: { in: [-1, 1] }
  validates :user_id, uniqueness: { scope: :photo_id }

  belongs_to :user
  belongs_to :photo, counter_cache: true

  def update_photo_ratings_sum
    photo.update_ratings_sum
  end
end
