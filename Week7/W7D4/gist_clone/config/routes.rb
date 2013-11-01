GistClone::Application.routes.draw do
  get "root/root"

  resources :users, :only => [:create, :new, :show]
  resource :session, :only => [:create, :destroy, :new]
  resources :gists, :except => [:new, :edit] do
    member do
      resource :star, :only => [:create, :destroy]
    end
  end
  resources :stars, :only => [:index]

  root :to => "root#root"
end
