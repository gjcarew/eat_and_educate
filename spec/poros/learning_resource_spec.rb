require 'rails_helper'

RSpec.describe LearningResource do
  it 'exists', :vcr do 
    image_data = ImageService.search('laos')
    video_data = VideoService.search('laos')
    resource = LearningResource.new(video_data, image_data, 'laos')
    expect(resource).to be_a LearningResource
  end

  it 'has attributes', :vcr do 
    image_data = ImageService.search('laos')
    video_data = VideoService.search('laos')
    resource = LearningResource.new(video_data, image_data, 'laos')
    expect(resource.id).to be_nil
    expect(resource.country).to eq('laos')

    expect(resource.video).to be_a Hash
    expect(resource.video[:title]).to be_a String
    expect(resource.video[:youtube_video_id]).to be_a String

    expect(resource.images).to be_an Array
    resource.images.each do |image|
      expect(image).to be_a Hash
      expect(image).to have_key :alt_tag
      expect(image).to have_key :url
    end
  end
end