class RecipeService
  def self.search(query)
    Rails.cache.fetch("recipe-#{query}", expires_in: 30.days) do 
      query_params = {
        type: 'public',
        app_id: ENV['RECIPE_ID'],
        app_key: ENV['RECIPE_KEY'],
        q: query,
        field: %w[label image url]
      }
      response = conn.get('api/recipes/v2', query_params)
      JSON.parse(response.body, symbolize_names: true)
    end
  end

  private

  def self.conn 
    Faraday.new(url: 'https://api.edamam.com') do |faraday|
      faraday.options.params_encoder = Faraday::FlatParamsEncoder
    end
  end
end