class User < ApplicationRecord
  before_validation :set_api_key
  validates :name, :email, :api_key, presence: true
  validates_uniqueness_of :email, { case_sensitive: false }
  validates_uniqueness_of :api_key
  has_secure_password

  private

    def set_api_key
      self.api_key = SecureRandom.hex if self.api_key.nil?
    end
end
