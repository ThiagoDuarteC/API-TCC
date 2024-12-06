Rails.application.routes.draw do
  resources :transactions do
    collection do
      get :load_info
    end
  end
  resources :reports do
    collection do
      get :category_by_debit
      get :category_by_credit
      get :balance_per_account
    end
  end
  resources :categories
  resources :accounts
  resources :goals
  resources :users do
    collection do
      get :get_user
    end
  end
  resources :dashboard
  resources :sessions
end
