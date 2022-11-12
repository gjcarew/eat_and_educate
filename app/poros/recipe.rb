class Recipe
  attr_reader :id, :title, :url, :country, :image
  
  def initialize(recipe, country)
    @id = nil
    @title = recipe[:recipe][:label]
    @url = recipe[:recipe][:url]
    @image = recipe[:recipe][:image]
    @country = country
  end

end