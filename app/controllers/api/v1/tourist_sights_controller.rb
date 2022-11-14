class Api::V1::TouristSightsController < ApplicationController
  def index
    if params[:country]
      response = TouristSightsFacade.country(params[:country])
    else
      response = TouristSightsFacade.random
    end
    render json: TouristSightSerializer.new(response)
  end
end