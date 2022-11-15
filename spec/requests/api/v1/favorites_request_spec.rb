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

  context 'GET /index' do 
    context 'happy path' do 
      it 'Gets all a users favorites when an api key is passed in' do 
        user = create(:user)
        create_list(:favorite, 3, user_id: user.id)

        get api_v1_favorites_path({ api_key: user.api_key })
        expect(response).to be_successful
        fav_hash = JSON.parse(response.body, symbolize_names: true)
        expect(fav_hash).to be_a Hash 
        expect(fav_hash[:data]).to be_an Array 
        fav_hash[:data].each do |favorite|
          expect(favorite[:type]).to eq('favorite')
          expect(favorite[:attributes].keys).to eq(%i[recipe_title recipe_link country created_at])
          expect(favorite[:attributes].values).to all(be_a String)
        end
      end

      it 'still returns an array when only one favorite is passed' do 
        user = create(:user)
        create(:favorite, user_id: user.id)

        get api_v1_favorites_path({ api_key: user.api_key })
        fav_hash = JSON.parse(response.body, symbolize_names: true)
        expect(fav_hash[:data]).to be_an Array
      end
    end

    context 'sad path/edge case' do
      it 'returns a 404 when there is no matching user' do 
        get api_v1_favorites_path({ api_key: 'does not matter' })
        expect(response.code).to eq('404')
        error = JSON.parse(response.body, symbolize_names: true)
        expect(error).to eq({ error: 'API key not found' })
      end

      it 'returns an empty array if the user does not have any favorites' do 
        user = create(:user)

        get api_v1_favorites_path({ api_key: user.api_key })
        expect(response.code).to eq('200')
        empty = JSON.parse(response.body, symbolize_names: true)
        expect(empty[:data]).to be_an Array
        expect(empty[:data]).to be_empty
      end
    end
  end
end
