class Api::V1::LearningResourcesController < ApplicationController
  def show
    return render status: :bad_request unless params[:country]

    resources = LearningFacade.from_country(params[:country])
    render json: LearningResourceSerializer.new(resources)
  end
end