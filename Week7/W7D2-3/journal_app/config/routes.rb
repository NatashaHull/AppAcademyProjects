JournalApp::Application.routes.draw do
  root :to => 'static_pages#root'
  resources :posts
end