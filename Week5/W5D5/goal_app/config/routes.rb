GoalApp::Application.routes.draw do
  resources :users, :only => [:new, :create, :show, :index]
  resource :session, :only => [:new, :create, :destroy]
  resources :goals do
    resources :cheers, :only => [:create, :destroy]
  end
end
