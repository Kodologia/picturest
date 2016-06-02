class Photo < ApplicationRecord
  validates :title, :description, :image, presence: true

  mount_uploader :image, ImageUploader
end
