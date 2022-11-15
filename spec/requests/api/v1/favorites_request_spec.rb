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

    context 'sad path' do 
      it 'Returns a 404 when the api key does not match an existing user' do 
        favorites_data = { 
          country: 'France',
          recipe_link: 'some_url',
          recipe_title: 'another_url',
          api_key: 'doesntmatter'
        }
  
        post api_v1_favorites_path, params: favorites_data
        favorite = JSON.parse(response.body, symbolize_names: true)
        expect(response.code).to eq('404')
        expect(favorite).to eq({ error: 'API key not found' })
      end

      it 'Returns a 400 error when a required field is missing' do 
        user = create(:user)
        favorites_data = { 
          country: nil,
          recipe_link: 'some_url',
          recipe_title: 'another_url',
          api_key: user.api_key
        }
  
        post api_v1_favorites_path, params: favorites_data
        favorite = JSON.parse(response.body, symbolize_names: true)
        expect(response.code).to eq('400')
        expect(favorite).to eq({
          country: [
              "can't be blank"
          ]
        })
      end
    end
  end
end
