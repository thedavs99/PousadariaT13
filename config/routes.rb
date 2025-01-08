Rails.application.routes.draw do
  devise_for :users
  devise_for :inn_owners
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"
  resources :inns, only: [:show] do
    resources :favorites_inns, only: [ :new, :create, :destroy ]
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :inns, only: [ :show ]
    end
  end

  resource :inn_management, only: [:show]

  resources :favorite_lists, only: [ :index, :new, :create, :show ]

  namespace :inn_dashboard do
    resource :inns, only: [:edit, :update] do
      resource :inn_rooms, only: [:new, :create]
    end

    resources :inn_rooms, only: [:show, :edit, :update]
  end
end
