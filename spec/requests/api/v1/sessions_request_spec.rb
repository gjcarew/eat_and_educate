require 'rails_helper'

RSpec.describe 'Sessions' do
  context 'log in' do 
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
end