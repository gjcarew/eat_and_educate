class Recipe
  attr_reader :title, :url, :country, :image
  
  def initialize(recipe, country)
    @title = recipe[:recipe][:label]
    @url = recipe[:recipe][:url]
    @image = recipe[:recipe][:image]
    @country = country
  end

end