Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'
  get 'about', to: 'home#about'
  get 'terms', to: 'home#terms'
  resources :photos
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
end
