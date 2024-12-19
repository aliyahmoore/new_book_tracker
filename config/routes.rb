Rails.application.routes.draw do
  # Devise routes for user authentication
  devise_for :users
  resources :users, only: [ :new, :create, :show, :edit, :update ]
  resources :book_clubs
  resources :books do
    resources :comments, only: [ :create, :destroy ]
  end

  root "booktracker#index"

  get "booktracker/new_search", to: "booktracker#new_search", as: "new_search"
  post "booktracker/create_from_api", to: "booktracker#create_from_api", as: "create_from_api"
  post "books/:id/add_to_user_books", to: "books#add_to_user_books", as: "book_add_to_user_books"


  resources :booktracker, only: [ :index, :new, :create, :show, :edit, :update, :destroy, :add_to_user_books ] do
    resources :books, only: [ :index, :show ], controller: "booktracker"
  end

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Render PWA files
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
