Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      get "/book-search", to: "books_search#show"
    end
    namespace :v0 do
      get "/forecast", to: 'forecast#show'
      resources :users, only: %i[create]
      post "/sessions", to: "users#login"
    end
  end
end
