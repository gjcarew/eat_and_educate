require 'rails_helper'

RSpec.describe 'Sessions' do
  context 'log in' do 
    context 'happy path' do 
      it 'A user can log in when their email and password are passed' do 
        user = create(:user, password: "password")
        login_info = {
          "email": user.email,
          "password": user.password
        }
        
        post api_v1_sessions_path, params: login_info
        expect(response).to be_successful
        logged_in = JSON.parse(response.body, symbolize_names: true)
        expect(logged_in).to be_a Hash
        expect(logged_in[:data][:type]).to eq('user')
        expect(logged_in[:data][:attributes].keys).to eq(%i[name email api_key])
      end
    end
    
    context 'sad path' do 
      it 'If they enter the wrong password, an error is returned' do 
        user = create(:user, password: "password")
        login_info = {
          "email": user.email,
          "password": 'wrong_pw'
        }

        post api_v1_sessions_path, params: login_info
        expect(response).to_not be_successful
        wrong_pw = JSON.parse(response.body, symbolize_names: true)
        expect(wrong_pw).to eq({ error: 'Incorrect password' })
      end

      it 'if they enter an email that does not exist, a 404 is returned' do 
        user = create(:user, password: "password")
        login_info = {
          "email": 'other@email.com',
          "password": user.password
        }

        post api_v1_sessions_path, params: login_info
        expect(response).to_not be_successful
        wrong_email = JSON.parse(response.body, symbolize_names: true)
        expect(wrong_email).to eq({ error: 'No user with that email' })
      end
    end
  end

  context 'log out' do
    context 'happy path' do 
      it 'a user can log out' do 
        user = create(:user, password: "password")
        login_info = {
          "email": user.email,
          "password": user.password
        }
        
        post api_v1_sessions_path, params: login_info
        expect(response).to be_successful

        delete api_v1_sessions_path({email: user.email})
        expect(response.status).to eq(204)
      end
    end
  end
end