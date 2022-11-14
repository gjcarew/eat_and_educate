class TouristSightsFacade
  def self.country(country)
    latlng = CountryService.latlng(country).first[:latlng]
    sights = PlacesService.tourist_sights(latlng)
    sights[:features].map do |sight|
      TouristSight.new(sight[:properties])
    end
  end
end