SecretShareAjax::Application.routes.draw do
  resources :users, :only => [:create, :new, :show] do
    resources :secrets, :only => [:new]
    resources :friendships, :only => [:create, :destroy]
  end

  resource :session, :only => [:create, :destroy, :new]
  resources :secrets, :only => [:create]

  root :to => "users#show"
end
