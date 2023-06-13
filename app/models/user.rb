class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :password_confirmation
  validates :api_key, uniqueness: true, presence: true

  has_secure_password
end