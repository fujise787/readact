Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root 'notes#index'

  resources :notes, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :categories, only: [:index, :new, :create, :edit, :update, :destroy]
end