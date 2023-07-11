Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :merchants do 
        resources :items
      end
    end
  end
  get "/api/v1/merchants/:id/items", to: "merchants/items#index"
end
