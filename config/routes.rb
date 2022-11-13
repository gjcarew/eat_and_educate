Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do 
      resources :recipes, only: :index
      resource :learning_resources, only: :show
    end
  end
end
