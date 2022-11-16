require 'rails_helper'

RSpec.describe ImageService do 
  context 'class methods' do 
    context '#search', :vcr do 
      before :each do 
        Rails.cache.clear
      end

      it 'returns images data from a search search', :vcr do
        search = ImageService.search('laos')
        expect(search).to be_a Hash 
        expect(search[:results]).to be_an Array
        search[:results].each do |result|
          expect(result[:alt_description]).to be_a String
          expect(result[:urls][:full]).to be_a String
        end
      end
    end
  end
end
