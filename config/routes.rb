Rails.application.routes.draw do
  root 'top#index'
  get 'about', to: 'top#about'

  resources :members do
    get 'search', on: :collection
  end

  resource :session, only: %i[create destroy]
end
