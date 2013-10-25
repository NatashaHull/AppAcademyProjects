ContactsApi::Application.routes.draw do
  resources :users, :except => [:new, :edit] do
    resources :contacts, :only => [:index]
  end
  resources :contacts, :except => [:index, :new, :edit]
  resources :contact_shares, :only => [:create, :destroy]
end
