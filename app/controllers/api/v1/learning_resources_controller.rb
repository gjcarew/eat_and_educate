class Api::V1::LearningResourcesController < ApplicationController
  def show
    require 'pry';binding.pry
    resources = LearningFacade.from_country(params[:country])
    LearningResourcesSerializer.new(resources)
  end
end