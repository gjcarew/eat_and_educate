class VideoService
  def self.search(query)
    response = conn.get('youtube/v3/search') do |req|
      req.params[:part] = 'snippet'
      req.params[:channelId] = 'UCluQ5yInbeAkkeCndNnUhpw' #MrHistory
      req.params[:maxResults] = 1
      req.params[:q] = query
      req.params[:type] = 'video'
      req.params[:key] = ENV['VIDEO_KEY']
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.conn
    Faraday.new('https://youtube.googleapis.com/')
  end
end
