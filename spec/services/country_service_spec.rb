require 'rails_helper'

RSpec.describe CountryService do 
  context 'class methods' do 
    context '#random' do 
      it 'returns a random country', :vcr do
        country = CountryService.random
        expect(country).to be_a String
      end
    end
  end
end