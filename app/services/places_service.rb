class PlacesService
  def tourist_sights(long, lat)
    sights = conn.get('/v2/places') do |req|
      req.params[:categories] = 'tourism.sights'
      req.params[:filter] = "circle:#{long},#{lat},20000"
      req.params[:categories] = 'tourism.sights'
      req.params[:apiKey] = ENV['PLACES_KEY']
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def conn 
    Faraday.new('https://api.geoapify.com')
  end
end