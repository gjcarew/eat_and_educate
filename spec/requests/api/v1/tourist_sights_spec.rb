require 'rails_helper'

RSpec.describe 'Tourist sights endpoint' do 
  context 'happy path' do 
    it 'gets a list of sights from a certain country', :vcr do 
      get api_v1_tourist_sights_path({country: 'France'})
      expect(response).to be_successful
      sights = JSON.parse(response.body, symbolize_names: true)
      expect(sights[:data]).to be_an Array
      sights[:data].each do |recipe|
        expect(recipe).to have_key :id
        expect(recipe[:type]).to eq('tourist_sight')
        expect(recipe[:attributes]).to be_a Hash
        expect(recipe[:attributes].keys).to eq(%i[name address place_id])
        expect(recipe[:attributes].values).to all(be_a String)
      end
    end

    # it "If the 'country' query param DNE, it returns recipes from a random country", :vcr do 
    #   allow(CountryService).to receive(:random).and_return('Ireland')
    #   get api_v1_recipes_path
    #   expect(response).to be_successful
    #   recipes = JSON.parse(response.body, symbolize_names: true)
    #   expect(recipes[:data]).to be_an Array
    #   recipes[:data].each do |recipe|
    #     expect(recipe).to have_key :id
    #     expect(recipe[:type]).to eq('recipe')
    #     expect(recipe[:attributes]).to be_a Hash
    #     expect(recipe[:attributes].keys).to eq(%i[title url country image])
    #     expect(recipe[:attributes].values).to all(be_a String)
    #   end
    end
  end

  # context 'sad path' do 
  #   it 'returns an empty array if there are no matches', :vcr do 
  #     get api_v1_recipes_path({country: 'xxxxxxxx'})
  #     expect(response).to be_successful
  #     empty_response = JSON.parse(response.body, symbolize_names: true)
  #     expect(empty_response).to eq({data: []})
  #   end

  #   it 'returns an empty array if no query string is entered', :vcr do 
  #     get api_v1_recipes_path({country: ''})
  #     expect(response).to be_successful
  #     empty_response = JSON.parse(response.body, symbolize_names: true)
  #     expect(empty_response).to eq({data: []})
  #   end
  # end
end