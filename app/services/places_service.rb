class PlacesService
  def self.tourist_sights(latlng)
    Rails.cache.fetch("sights-#{latlng}", expires_in: 30.days) do
      response = conn.get('/v2/places') do |req|
        req.params[:categories] = 'tourism.sights'
        req.params[:filter] = "circle:#{latlng[1]},#{latlng[0]},20000"
        req.params[:apiKey] = ENV['PLACES_KEY']
      end
      JSON.parse(response.body, symbolize_names: true)
    end
  end

  private

  def self.conn 
    Faraday.new('https://api.geoapify.com')
  end
end