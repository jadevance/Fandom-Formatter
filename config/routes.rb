Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get '/home' => 'home#index'
  post '/home' => 'home#create', as: :files   

  resources :sessions, only: [:create, :destroy]
  resources :home, only: [:index]

  root to: "home#index"
end
