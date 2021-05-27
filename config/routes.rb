Rails.application.routes.draw do
  devise_for :users
  resources :mybooks
  #get 'home/index'
  root 'mybooks#index'
  get 'home/about'
  get 'browse', to:"mybooks#browse"  

end
