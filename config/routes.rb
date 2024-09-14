Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users
  resources :ferments

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  get "up" => "rails/health#show", as: :rails_health_check
  get "users/:id/profile", to: "users#show", as: :profile
  # Defines the root path route ("/")
  # root "posts#index"
end
