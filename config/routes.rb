Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do 
      resources :recipes, only: :index
      resource :learning_resources, only: :show
      resources :users, only: :create
      resources :tourist_sights, only: :index
      resources :favorites, only: %i[create index]
    end
  end
end
