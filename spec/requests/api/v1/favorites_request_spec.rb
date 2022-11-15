require 'rails_helper'

RSpec.describe "Favorites", type: :request do
  context 'POST /create' do
    context 'happy path' do 
      it 'creates a new favorite from params in the request body' do
        user = create(:user)
        favorites_data = { 
          country: 'France',
          recipe_link: 'some_url',
          recipe_title: 'another_url',
          api_key: user.api_key
        }

        post api_v1_favorites_path, params: favorites_data
        favorite_success = JSON.parse(response.body, symbolize_names: true)
        expect(response.code).to eq('201')
        expect(favorite_success).to eq({ success: 'Favorite added successfully' })
      end
    end
  end
end
