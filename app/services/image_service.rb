class ImageService
  def self.search(query)
    response = conn.get('search/photos') do |req|
      req.params[:client_id] = ENV['IMAGE_KEY']
      req.params[:query] = query
      req.params[:per_page] = 10
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.conn
    Faraday.new('https://api.unsplash.com/')
  end
end