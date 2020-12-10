Rails.application.routes.draw do
  get 'accounts/show'
  get 'accounts/edit'
  root 'top#index'
  get 'about', to: 'top#about'

  resources :members do
    get 'search', on: :collection
  end

  resource :session, only: %i[create destroy]
  resource :account, only: %i[show edit update]
end
