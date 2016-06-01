Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'
  get 'about', to: 'home#about'
  get 'terms', to: 'home#terms'
  resources :photos
end
