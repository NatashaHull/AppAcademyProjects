RedditClone::Application.routes.draw do
  resources :users, :only => [:new, :create]
  resource :session, :only => [:new, :create, :destroy]

  resources :subs
  resources :links do
    resources :comments, :only => [:new, :create]
  end
end
