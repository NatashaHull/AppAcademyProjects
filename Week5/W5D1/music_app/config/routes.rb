MusicApp::Application.routes.draw do
  resource :session, :only => [:new, :create, :destroy]
  
  resources :users do
    collection do
      get 'activate' #Should potentially be a put or post
    end
    put 'admin' #For creating admins
  end
  
  resources :bands do
    resources :albums, :only => [:index, :new, :create]
  end

  resources :albums, :except => [:index, :new, :create] do
    resources :tracks, :only => [:index, :new, :create]
  end
  
  resources :tracks, :except => [:index, :new, :create] do
    resources :notes, :only => [:create]
  end

  resources :notes, :only => [:destroy]

  root :to => 'bands#index'
end
