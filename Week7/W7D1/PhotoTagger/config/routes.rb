NewAuthDemo::Application.routes.draw do
  get "static_pages/root"

  namespace "api", :defaults => { :format => :json } do
    resources :photos, :only => [:create, :update] do
      resources :photo_taggings, :only => [:index]
    end

    resources :photo_taggings, :only => [:create]
  end

  resources :users, :only => [:create, :new, :show] do
    resources :photos, :only => [:index]
  end
  resource :session, :only => [:create, :destroy, :new]

  root :to => "static_pages#root"
end
