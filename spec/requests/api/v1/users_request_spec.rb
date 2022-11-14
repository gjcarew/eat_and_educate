require 'rails_helper'

RSpec.describe 'User' do
  context 'Registration' do 
    context 'happy path' do 
      it 'A user can register with a name, email, password, and password confirmation' do
        user = {
          "name": 'Athena Dao',
          "email": 'athenadao@bestgirlever.com',
          "password": 'password',
          "password_confirmation": 'password'
        }

        post api_v1_users_path, params: user
        expect(response.status).to eq(201)
        user = JSON.parse(response.body, symbolize_names: true)
        expect(user[:data][:attributes].keys).to eq(%i[name email api_key]) 
      end 
    end

    context 'Sad path' do 
      it 'Emails must be unique' do 
        user_1 = {
          "name": 'Athena Dao',
          "email": 'athenadao@bestgirlever.com',
          "password": 'password',
          "password_confirmation": 'password'
        }

        user_2 = {
          "name": 'Same user',
          "email": 'athenadao@bestgirlever.com',
          "password": 'password',
          "password_confirmation": 'password'
        }

        post api_v1_users_path, params: user_1
        post api_v1_users_path, params: user_2

        expect(response.status).to eq(422)
        error_body = JSON.parse(response.body, symbolize_names: true)
        expect(error_body).to eq({:email=>["has already been taken"]})
      end

      it 'Password and password confirmation must match' do 
        user_1 = {
          "name": 'Athena Dao',
          "email": 'athenadao@bestgirlever.com',
          "password": 'password',
          "password_confirmation": 'other_word'
        }

        post api_v1_users_path, params: user_1

        expect(response.status).to eq(422)
        error_body = JSON.parse(response.body, symbolize_names: true)
        expect(error_body).to eq({:password_confirmation=>["doesn't match Password"]})
      end
    end
  end
end