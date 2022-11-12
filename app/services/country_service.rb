class CountryService

  def self.random
    response = conn.get('v2/all?fields=name')
    arr = JSON.parse(response.body, symbolize_names: true)
    arr.map { |country| country[:name] }.sample
  end

  private

  def self.conn
    Faraday.new('https://restcountries.com')
  end
end