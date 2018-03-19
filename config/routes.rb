Rails.application.routes.draw do

  root "static_pages#home"
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  resources :users, only: [:index, :show]
  resources :requests
  resources :applies, only: [:create]
  resources :diplomas, only: [ :create, :destroy]

  namespace :admin do
    root "admin#index"
    resources :diplomas
  end

  mount ActionCable.server, at: '/cable'
end
