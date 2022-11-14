require 'rails_helper'

RSpec.describe TouristSight do 
  it 'exists', :vcr do 
    sight_data = PlacesService.tourist_sights([2.0, 46.0])[:features].first[:properties]
    sight_obj = TouristSight.new(sight_data)
    expect(sight_obj).to be_a TouristSight
  end
  
  it 'has attributes', :vcr do
    sight_data = PlacesService.tourist_sights([2.0, 46.0])[:features].first[:properties]
    sight_obj = TouristSight.new(sight_data)
    expect(sight_obj.name).to be_a String
    expect(sight_obj.id).to be_nil
    expect(sight_obj.address).to be_a String
    expect(sight_obj.place_id).to be_a String
  end
end