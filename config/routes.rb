Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get '/about', to: 'home#about', as: 'about'
  post '/home' => 'home#create', as: :files   

  resources :sessions, only: [:create, :destroy]

  root to: "home#index"
end
