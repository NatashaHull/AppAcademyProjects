NewReader::Application.routes.draw do
  get "root/root"

  resources :feeds, only: [:index, :create] do
    resources :entries, only: [:index]
  end

  root to: "feeds#index"
end
