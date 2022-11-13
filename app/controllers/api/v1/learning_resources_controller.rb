class Api::V1::LearningResourcesController < ApplicationController
  def show
    resources = LearningFacade.from_country(params[:country])
    render json: LearningResourceSerializer.new(resources)
  end
end