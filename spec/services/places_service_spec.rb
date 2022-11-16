require 'rails_helper'

RSpec.describe PlacesService do 
  context 'class methods' do 
    context '#tourist_sights' do 
      before :each do 
        Rails.cache.clear
      end
      
      it 'returns a list of tourist sights within 20 k of the capital', :vcr do
        search = PlacesService.tourist_sights([33.0, 65.0])
        expect(search).to be_a Hash 
        expect(search[:features]).to be_an Array
        search[:features].each do |sight|
          expect(sight[:properties][:name]).to be_a String
          expect(sight[:properties][:formatted]).to be_a String
          expect(sight[:properties][:place_id]).to be_a String
        end
      end
    end
  end
end