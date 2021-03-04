Rails.application.routes.draw do
  root 'welcome#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_scope :user do
    get 'users/sign_in', to: 'users/sessions#new', as: 'new_user_session'
    get 'users/sign_out', to: 'users/sessions#destroy', as: 'destroy_user_session'
  end

  resources :users, only: %i[create destroy edit update]
  
  namespace :users do
    resources :friends, only: [:index]
    get "friends/search", to: "friends#search"
  end
  
  resources :dashboard, module: :users, only: [:index]
  resources :referral, module: :users, only: [:index]


  resources :utilities, only: [:index], as: 'utilities'

  resources :sessions, only: [:create]
  get 'about', to: 'welcome#about', as: 'about'
  get 'contact', to: 'welcome#contact', as: 'contact'
end
