Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do  
   get '/users/sign_out' => 'devise/sessions#destroy'     
  end
  resources :checkout, only: [:create]
  post "checkout/create", to: "checkout#create"
  post "mybooks/add_to_cart/:id", to: "mybooks#add_to_cart", as: "add_to_cart"
  delete "mybooks/remove_from_cart/:id", to: "mybooks#remove_from_cart", as: "remove_from_cart"
  resources :mybooks do
    collection do
    	get :autocomplete
    end
  end
  #get 'home/index'
  root 'mybooks#index'
  get 'home/about'
  get 'browse', to:"mybooks#browse"  
  get "success", to:"checkout#success"
  get "cancel", to:"checkout#cancel"
  
end
