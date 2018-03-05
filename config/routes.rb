Rails.application.routes.draw do
  root "static_pages#home"
  get "/test", to: "static_pages#test"
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  resources :requests

end
