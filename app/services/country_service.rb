class CountryService

  def self.random
    response = conn.get('v2/all?fields=name')
    arr = JSON.parse(response.body, symbolize_names: true)
    arr.map { |country| country[:name] }.sample
  end

  def self.latlng(country)
    Rails.cache.fetch("latlng-#{country}", expires_in: 90.days) do
      response = conn.get("v3.1/name/#{country}") do |req|
        req.params[:fields] = 'name,latlng'
      end
      JSON.parse(response.body, symbolize_names: true)
    end
  end

  private

  def self.conn
    Faraday.new('https://restcountries.com')
  end
end