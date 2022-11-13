class Api::V1::RecipesController < ApplicationController
  def index
    require 'pry';binding.pry
    if params[:country]
      response = RecipeFacade.search(params[:country])
    else
      response = RecipeFacade.random
    end
    render json: RecipeSerializer.new(response)
  end
end