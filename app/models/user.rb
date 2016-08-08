class User < ApplicationRecord
  before_save :downcase_email
  validates :email, presence: true,
    format: { with: /\A([^@\s]+)@[a-z\d\-.]+\.[a-z]{2,}\z/i },
    uniqueness: { case_sensitive: false }
  validates :first_name, :last_name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :password, presence: true, length: { minimum: 6 }

  has_secure_password

  has_many :photos, dependent: :destroy
  has_many :ratings
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :saved_photos, class_name: 'Photo'

  def downcase_email
    email.downcase!
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
