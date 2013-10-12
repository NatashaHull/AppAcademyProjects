PracticeProject::Application.routes.draw do
  resources :users, :except => [:edit, :update, :destroy]
  resource :session, :only => [:new, :create, :destroy]
  resource :following, :only => [:create, :destroy]
end