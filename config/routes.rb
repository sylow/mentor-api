Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :v1 do
    resources :users
    resources :records
    resources :images
    resources :sessions do
      get :token, on: :collection
    end
  end
end
