Links::Application.routes.draw do
  resources :users
  resource :session
  resources :links do
    resources :comments, except: [:destroy]
  end
  resources :comments, only: [:destroy]
  
  root :to => "sessions#new"
end
