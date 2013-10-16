FriendsCircle::Application.routes.draw do
  resources :users, :except => [:destroy] do
    collection do
      get 'reset_password_email'
      put 'reset_password_submit'
      get 'reset_password'
    end

    resources :circles, :only => [:new, :create]
    resources :friends, :only => [:create]
  end

  resource :session, :only => [:new, :create, :destroy]
  resources :circles, :only => [:destroy]
  resources :friends, :only => [:destroy]
end