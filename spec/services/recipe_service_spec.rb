require 'rails_helper'

RSpec.describe RecipeService do 
  context 'class methods' do 
    context '#search' do 
      it 'returns recipe data', :vcr do
        search = RecipeService.search('thailand')
        expect(search).to be_a Hash 
        search[:hits].each do |hit|
          expect(hit[:recipe][:url]).to be_a String
          expect(hit[:recipe][:label]).to be_a String
          expect(hit[:recipe][:image]).to be_a String
        end
      end
    end
  end
end
