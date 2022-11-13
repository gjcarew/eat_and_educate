require 'rails_helper'

RSpec.describe LearningFacade do 
  context 'class methods' do 
    context '#from_country' do 
      it 'creates a learning resources object from video and image data', :vcr do
         LearningFacade.from_country('laos')
         expect(LearningFacade.from_country('laos')).to be_a LearningResource
      end
    end
  end
end

