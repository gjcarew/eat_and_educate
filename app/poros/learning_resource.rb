class LearningResource
  attr_reader :id, :country, :video, :images

  def initialize(video_data, image_data, query)
    @id = nil 
    @country = query
    @video ||= generate_video(video_data)
    @images ||= generate_images(image_data)
  end

  def generate_video(video_data)
    return {} if video_data[:items].empty?

    {
      title: video_data[:items][0][:snippet][:title],
      youtube_video_id: video_data[:items][0][:id][:videoId]
    }
  end

  def generate_images(image_data)
    return [] if image_data[:results].empty?

    image_data[:results].map do |image|
      {
        alt_tag: image[:alt_description],
        url: image[:urls][:full]
      }
    end
  end
end