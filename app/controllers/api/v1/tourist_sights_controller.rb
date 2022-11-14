class Api::V1::TouristSightsController < ApplicationController
  def index
    response = TouristSightsFacade.country(params[:country])
    render json: TouristSightSerializer.new(response)
  end
end