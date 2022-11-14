class TouristSightsController < ApplicationController
  def index
    response = TouristSightsFacade.country(params[:country])
    render json: TourisSightSerializer.new(response)
  end
end