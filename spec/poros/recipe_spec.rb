require 'rails_helper'

RSpec.describe Recipe do 
  it 'exists', :vcr do 
    recipe_data = RecipeService.search('thailand')[:hits].first
    recipe = Recipe.new(recipe_data, 'thailand')
    expect(recipe).to be_a Recipe
  end

  it 'has attributes', :vcr do 
    recipe_data = RecipeService.search('thailand')[:hits].first
    recipe = Recipe.new(recipe_data, 'thailand')
    expect(recipe.title).to eq("Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)")
    expect(recipe.url).to eq("https://www.seriouseats.com/recipes/2013/11/andy-rickers-naam-cheuam-naam-taan-piip-palm-sugar-simple-syrup.html")
    expect(recipe.country).to eq('thailand')
    expect(recipe.image).to be_a String
  end
end