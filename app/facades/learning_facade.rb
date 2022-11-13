class LearningFacade
  def self.from_country(query)
    image_data = ImageService.search(query)
    video_data = VideoService.search(query)
    LearningResource.new(video_data, image_data, query)
  end
end