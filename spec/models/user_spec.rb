require 'rails_helper'
RSpec.describe User, type: :model do
  describe 'relationships' do
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive.on(:create) }
    it { should validate_uniqueness_of(:api_key).on(:create) }
    it { should have_secure_password }
  end

  describe 'instance methods' do
  end
end