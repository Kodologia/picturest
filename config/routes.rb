Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'
  get 'about', to: 'home#about'
  get 'terms', to: 'home#terms'
  resources :photos
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'account', to: 'users#account'
end
