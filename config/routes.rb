Rails.application.routes.draw do
  root to: "home#index"
  
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure',            to: redirect('/')
  get 'signout',                 to: 'sessions#destroy', as: :signout
  get '/about',                  to: 'home#about',       as: :about
  get '/home',                   to: 'home#index'
  post '/home',                  to: 'home#create',      as: :files   
  post '/home/markup',           to: 'home#markup',      as: :markup 
  post '/home/markdown',         to: 'home#markdown',    as: :markdown

end
