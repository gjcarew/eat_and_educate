class PlacesService
  def self.tourist_sights(latlng)
    response = conn.get('/v2/places') do |req|
      req.params[:categories] = 'tourism.sights'
      req.params[:filter] = "circle:#{latlng[0]},#{latlng[1]},20000"
      req.params[:categories] = 'tourism.sights'
      req.params[:apiKey] = ENV['PLACES_KEY']
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.conn 
    Faraday.new('https://api.geoapify.com')
  end
end