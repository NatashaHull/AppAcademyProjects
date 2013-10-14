MusicApp::Application.routes.draw do
  resource :session, :only => [:new, :create, :destroy]
  
  resources :users do
    collection do
      get 'activation' #Should potentially be a put or post
    end
  end
  
  resources :bands do
    resources :albums, :only => [:index, :new, :create]
  end

  resources :albums, :except => [:index, :new, :create] do
    resources :tracks, :only => [:index, :new, :create]
  end
  
  resources :tracks, :except => [:index, :new, :create] do
    resources :notes, :only => [:create, :destroy]
  end
end
