class ImageService
  def self.search(query)
    Rails.cache.fetch("image-#{query}", expires_in: 30.days) do 
      response = conn.get('search/photos') do |req|
        req.params[:client_id] = ENV['IMAGE_KEY']
        req.params[:query] = query
        req.params[:per_page] = 10
      end
      JSON.parse(response.body, symbolize_names: true)
    end
  end

  private

  def self.conn
    Faraday.new('https://api.unsplash.com/')
  end
end