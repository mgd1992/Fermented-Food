require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  root to: "pages#home"
  devise_for :users

  resources :users do
    resources :ferments do
      resources :comments, only: [:create, :destroy]
    end
  end
  resources :ferments

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"

    mount Sidekiq::Web => '/sidekiq'
  end


  get "up" => "rails/health#show", as: :rails_health_check
  get "users/:id/profile", to: "users#show", as: :profile

end
