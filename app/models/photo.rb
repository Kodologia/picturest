class Photo < ApplicationRecord
  validates :title, :description, :image, presence: true
end
