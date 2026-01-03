Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  resources :users, only: [ :new, :create, :update ]

  resources :flights
  resources :airports, only: :show
  # React
  get "/app", to: "react_ui#show"
  get "/app/*path", to: "react_ui#show"

  # Hotwire
  root "home#show"
end
