require 'rails_helper'

RSpec.describe VideoService do 
  context 'class methods' do 
    context '#search' do 
      before :each do 
        Rails.cache.clear
      end
      
      it 'returns a youtube search', :vcr do
        search = VideoService.search('laos')
        expect(search).to be_a Hash 
      end
    end
  end
end
