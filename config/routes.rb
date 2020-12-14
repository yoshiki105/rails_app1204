Rails.application.routes.draw do
  root 'top#index'
  get 'about', to: 'top#about'
  get '/bad_request', to: 'top#bad_request'
  get '/forbidden', to: 'top#forbidden'
  get '/internal_server_error', to: 'top#internal_server_error'

  # 普通のリソース
  resources :members do
    get 'search', on: :collection
    resources :entries, only: :index
  end
  resources :entries do
    resources :images, controller: 'entry_images' do # EntryImagesコントローラーのパスをimageで定義
      patch :move_hegher, :move_lower, on: :member
    end
  end

  # 単数リソース
  resource :session, only: %i[create destroy]
  resource :account, only: %i[show edit update]
  resource :password, only: %i[show edit update]
end
