require 'rails_helper'

RSpec.describe ImageService do 
  context 'class methods' do 
    context '#search' do 
      it 'returns images data from a search search', :vcr do
        search = ImageService.search('laos')
        expect(search).to be_a Hash 
      end
    end
  end
end