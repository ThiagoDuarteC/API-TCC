Rails.application.routes.draw do
  resources :transactions
  resources :categories
  resources :accounts
  resources :goals
  resources :users
end
