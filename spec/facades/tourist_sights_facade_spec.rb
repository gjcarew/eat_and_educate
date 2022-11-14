require 'rails_helper'

RSpec.describe TouristSightsFacade do 
  it 'creates an array of TouristSights from a country' do 
    sights = TouristSightsFacade.country('France')
    expect(sights).to be_an Array
    expect(sights).to all(be_a TouristSight)
  end
end