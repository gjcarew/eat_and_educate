require 'rails_helper'

RSpec.describe RecipeFacade do 
  describe 'class methods' do 
    describe '#search' do 
      it 'creates an array of recipe objects from search results', :vcr do 
        search_results = RecipeFacade.search('thailand')
        expect(search_results).to be_an Array
        expect(search_results).to all(be_a Recipe)
      end

      it 'Single results are still returned as an array' do 
        mock_data = {hits: [
            {
            recipe: {
              label: 'Single label',
              url: 'single.url',
              image: 'single image'
            }
          }]
        }
        allow(RecipeService).to receive(:search).and_return(mock_data)

        search_results = RecipeFacade.search('thailand')
        expect(search_results.length).to eq(1)
        expect(search_results).to be_an Array 
        expect(search_results[0]).to be_a Recipe
      end

      it 'When there are no search results, an empty array is returned' do 
        mock_data = {hits: []}
        allow(RecipeService).to receive(:search).and_return(mock_data)
        search_results = RecipeFacade.search('thailand')
        expect(search_results).to be_an Array 
        expect(search_results).to be_empty
      end
    end
    
    describe '#random' do 
      it 'creates an array of recipes from a random country', :vcr do 
        allow(CountryService).to receive(:random).and_return('thailand')
        search_results = RecipeFacade.random
        expect(search_results).to be_an Array
        expect(search_results).to all(be_a Recipe)
      end
    end
  end
end