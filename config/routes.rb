Rails.application.routes.draw do
  resources :transactions do
    collection do
      get :load_info
    end
  end
  resources :categories
  resources :accounts
  resources :goals
  resources :users
  resources :dashboard
  resources :sessions
end
