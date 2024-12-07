Rails.application.routes.draw do
  # Devise routes for user authentication
  devise_for :users
  resources :book_clubs, only: [ :index, :show, :new, :create, :edit, :update, :destroy ]
  resources :books, only: [ :index, :show, :new, :create, :edit, :update, :destroy ]
  resources :users, only: [ :show, :edit, :update ]

  root "booktracker#index"

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Render PWA files
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
