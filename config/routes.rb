Rails.application.routes.draw do
  root 'home#index'

  resources :users, only: [:index, :show]

  namespace :api do
    namespace :v1 do
      resources :users, only: :index
    end
  end
end
