class TouristSightsFacade
  def self.country(country)
    latlng = CountryService.latlng(country)
    return [] unless latlng.is_a?(Array)

    latlng = latlng.first[:latlng]
    sights = PlacesService.tourist_sights(latlng)
    sights[:features].map do |sight|
      TouristSight.new(sight[:properties])
    end
  end

  def self.random
    rand_country = CountryService.random
    country(rand_country)
  end
end