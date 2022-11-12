class RecipeFacade
  def self.search(query)
    results = RecipeService.search(query)
    create_recipes(results, query)
  end

  def self.random
    country = CountryService.random
    results = RecipeService.search(country)
    create_recipes(results, country)
  end

  private

  def create_recipes(results, query)
    results[:hits].map do |hit|
      Recipe.new(hit, query)
    end
  end
end