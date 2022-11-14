require 'rails_helper'

RSpec.describe PlacesService do 
  context 'class methods' do 
    context '#tourist_sights' do 
      it 'returns a list of tourist sights within 20 k of the capital', :vcr do
        search = PlacesService.tourist_sights(-87.770231, 41.878968)
        expect(search).to be_a Hash 
        require 'pry';binding.pry
      end
    end
  end
end