Rails.application.routes.draw do

  root "static_pages#home"
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  resources :users, only: [:index, :show]
  resources :requests
  resources :applies, only: [:create]
  resources :diplomas, only: [ :create, :destroy]

  mount ActionCable.server, at: '/cable'
  mount RailsAdmin::Engine => "/admin", as: :rails_admin
end
