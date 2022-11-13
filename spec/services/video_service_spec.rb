require 'rails_helper'

RSpec.describe VideoService do 
  context 'class methods' do 
    context '#search' do 
      it 'returns recipe data', :vcr do
        search = VideoService.search('laos')
        expect(search).to be_a Hash 
        expect(search[:items][0][:id][:videoId]).to be_a String
        expect(search[:items][0][:snippet][:title]).to be_a String
      end
    end
  end
end