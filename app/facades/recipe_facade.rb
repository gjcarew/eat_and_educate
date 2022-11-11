class RecipeFacade
  def self.search(query)
    results = RecipeService.search(query)
    results[:hits].map do |hit|
      Recipe.new(hit, query)
    end
  end
end