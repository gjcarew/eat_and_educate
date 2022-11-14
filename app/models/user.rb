class User < ApplicationRecord
  validates :name, :email, :password_digest, presence: true
  validates_uniqueness_of :email, { case_sensitive: false }
  validates_uniqueness_of :api_key
  has_secure_password
  before_save { self.email = email.downcase }
end
