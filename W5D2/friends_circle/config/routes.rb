FriendsCircle::Application.routes.draw do
  resources :users, :except => [:destroy] do
    collection do
      get 'reset_password_email'
      put 'reset_password_submit'
      get 'reset_password'
    end
  end
  resource :session, :only => [:new, :create, :destroy]
end
