NinetyNineCats::Application.routes.draw do
  root :to => "cats#index"

  resources :cats
  resources :cat_rentals, :only => [:new, :create, :update]
end
