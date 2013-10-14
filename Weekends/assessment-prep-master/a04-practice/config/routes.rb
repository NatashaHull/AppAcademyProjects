Links::Application.routes.draw do
  resources :users, :only => [:new, :create]
  resources :links
  resource :session, :only => [:new, :create, :destroy]
  resources :comments, :only => [:create, :destroy]
end
