Rails.application.routes.draw do
  root 'photos#index'
  get 'about', to: 'home#about'
  get 'terms', to: 'home#terms'

  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'account', to: 'profiles#account'
  get 'photos_collection', to: 'profiles#photos_collection'

  resources :photos do
    resources :comments, only: :create
    member do
      post 'rate'
      post 'save_to_user_collection'
    end
  end
end
