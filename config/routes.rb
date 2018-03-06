Rails.application.routes.draw do

  scope "(:locale)", :locale => /en|vi/ do
    root "static_pages#home"
  end
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  resources :users, only: [:index, :show]
  resources :requests

  namespace :admin do
    root "admin#index"
    resources :diploma
  end
end
