Rails.application.routes.draw do
  get 'passwords/edit'
  get 'accounts/show'
  get 'accounts/edit'
  root 'top#index'
  get 'about', to: 'top#about'

  # 普通のリソース
  resources :members do
    get 'search', on: :collection
    resources :entries, only: [:index]
  end
  resources :entries

  # 単数リソース
  resource :session, only: %i[create destroy]
  resource :account, only: %i[show edit update]
  resource :password, only: %i[show edit update]
end
