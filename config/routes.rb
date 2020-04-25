Rails.application.routes.draw do
  resources :orders
  resources :order_items
  resources :products

  #Route for Twitter authentication
  #get '/auth/:provider/callback', to: 'sessions#create'
  
  # Routes for Google authentication
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')

  get "/login" => redirect( "/auth/google_oauth2"), as: :login
  get "/logout" => "sessions#destroy", as: :logout

  root to: 'products#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
