class PlacesService
  def self.tourist_sights(latlng)
    response = conn.get('/v2/places') do |req|
      req.params[:categories] = 'tourism.sights'
      req.params[:filter] = "circle:#{latlng[1]},#{latlng[0]},20000"
      req.params[:apiKey] = ENV['PLACES_KEY']
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.conn 
    Faraday.new('https://api.geoapify.com')
  end
end