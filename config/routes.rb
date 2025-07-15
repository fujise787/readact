Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
    }

  get "up" => "rails/health#show", as: :rails_health_check

  root to: 'notes#new'

  resources :notes, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :categories, only: [:index, :new, :create, :edit, :update, :destroy]
end
