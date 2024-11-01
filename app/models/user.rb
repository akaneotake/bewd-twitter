class User < ApplicationRecord
  # Relationships
  has_many :sessions, dependent: :destroy
  has_many :tweets, dependent: :destroy

  # Validations
  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 64 }
  validates :password, presence: true, length: { minimum: 8, maximum: 64 }
  validates :email, presence: true, uniqueness: true, length: { minimum: 5, maximum: 500 },
                    format: { with: URI::MailTo::EMAIL_REGEXP }

  # Secure password storage
  has_secure_password
end
