require 'rails_helper'

RSpec.describe CountryService do 
  context 'class methods' do 
    context '#random' do 
      it 'returns a random country', :vcr do
        country = CountryService.random
        expect(country).to be_a String
      end
    end

    context '#latlng' do 
      it 'gets the latitude and longitude for a country', :vcr do 
        latlng = CountryService.latlng('France')
        # require 'pry';binding.pry
        expect(latlng).to be_an Array
        expect(latlng.first[:latlng]).to all(be_a Float)
      end
    end
  end
end