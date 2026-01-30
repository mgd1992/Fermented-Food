  require 'sidekiq/web'
  require 'sidekiq-scheduler/web'

  Rails.application.routes.draw do
    root to: "pages#home"
    devise_for :users

    # Rutas de usuarios y fermentos anidados
    resources :users do
      resources :ferments do
        resources :comments, only: [:create, :destroy]
      end
    end

    # Ferments independientes
    resources :ferments, only: [:show, :index, :edit, :update, :destroy] do
      member do
        delete "photos/:photo_id", to: "ferments#destroy_photo", as: :destroy_photo
      end
    end

    #Rutas de mensajes
    resources :messages, only: [:index, :new, :create, :show, :destroy]
    get 'users/:recipient_id/message', to: 'messages#new', as: :new_user_message

    #Ruta al perfil de usuario
    get "users/:id/profile", to: "users#show", as: :profile

    # Herramientas solo en desarrollo
    if Rails.env.development?
      mount LetterOpenerWeb::Engine, at: "/letter_opener"

      mount Sidekiq::Web => '/sidekiq'
    end

    # Health check
    get "up" => "rails/health#show", as: :rails_health_check

  end
