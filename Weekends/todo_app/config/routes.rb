TodoApp::Application.routes.draw do
  resources :tasks, :only => [:create, :index]
  root :to => "tasks#index"
end
