Rails.application.routes.draw do
  resources :orders
  resources :order_items
  resources :products

  #Route for Twitter authentication
  #get '/auth/:provider/callback', to: 'sessions#create'
  
  # Routes for Google authentication
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
