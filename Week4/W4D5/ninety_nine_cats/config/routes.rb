NinetyNineCats::Application.routes.draw do
  resource :user, :except => [:edit, :destroy] do
    collection do
      get 'edit'
    end
  end
  resource :session, :only => [:new, :create, :destroy] do
    collection do
      get 'see_request_possibilities'
    end
  end

  root :to => "cats#index"

  resources :cats
  resources :cat_rentals, :only => [:new, :create, :update] do
  	post "approve"
  	post "deny"
  end
end
