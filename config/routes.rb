Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get 'login', to: 'sessions#new', as: 'login'
  resources :sessions, only: [:create]
  get 'registration', to: 'users#new', as: 'registration'

  get 'logout', to: 'sessions#destroy', as: 'logout'
end
