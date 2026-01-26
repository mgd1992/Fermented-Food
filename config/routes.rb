require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  root to: "pages#home"
  devise_for :users

  resources :users do
    resources :ferments do
      resources :comments, only: [:create, :destroy]
      member do
        delete "photos/:photo_id", to: "ferments#destroy_photo", as: :destroy_photo
      end
    end
  end
  resources :ferments
  resources :messages, only: [:index, :new, :create, :show]

  get 'users/:recipient_id/message', to: 'messages#new', as: :new_user_message


  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"

    mount Sidekiq::Web => '/sidekiq'
  end


  get "up" => "rails/health#show", as: :rails_health_check
  get "users/:id/profile", to: "users#show", as: :profile

end
