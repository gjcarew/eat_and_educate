require 'rails_helper'

RSpec.describe 'Learning resources' do 
  context 'happy path' do 
    it 'returns a hash of learning resources', :vcr do 
      visit api_v1_learning_resources_path({country: 'laos'})
      expect(response).to be_successful

      resources = JSON.parse(response.body, symbolize_names: true)
      expect(resources).to be_a Hash
      expect(resouces[:data][:id]).to be_nil
      expect(resources[:data][:type]).to eq('learning_resource')
      expect(resources[:data][:attributes]).to be_a Hash
    end

    it 'has a country, video, and images', :vcr do
      visit api_v1_learning_resources_path({country: 'laos'})
      resources = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

      expect(resources[:country]).to eq('laos')
      expect(resources[:video][:title]).to be_a String 
      expect(resources[:video][:youtube_video_id]).to be_a String

      expect(resources[:images]).to be_an Array
      resources[:images].each do |image|
        expect(image).to be_a Hash
        expect(image[:alt_tag]).to be_a String
        expect(image[:url]).to be_a String
      end
    end
  end
end