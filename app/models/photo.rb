class Photo < ApplicationRecord
  validates :title, :description, presence: true
  validates :image, presence: true unless Rails.env.test?

  belongs_to :user
  has_many :ratings, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :saving_users, class_name: 'User'

  mount_uploader :image, ImageUploader

  self.per_page = 15

  def update_ratings_sum
    update(ratings_sum: ratings.sum(:value))
  end
end
