class User < ApplicationRecord
  validates :name, :email, :api_key, presence: true
  validates_uniqueness_of :email, { case_sensitive: false }
  validates_uniqueness_of :api_key
  has_secure_password

end
