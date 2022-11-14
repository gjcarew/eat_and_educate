require 'rails_helper'

RSpec.describe PlacesService do 
  context 'class methods' do 
    context '#tourist_sights' do 
      it 'returns a list of tourist sights within 20 k of the capital', :vcr do
        search = PlacesService.tourist_sights(-87.770231, 41.878968)
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