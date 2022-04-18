Rails.application.routes.draw do
  devise_for :users
  resources :courses
  root 'static_pages#landing_pages'
  get 'static_pages/activity'
  get 'privacy_policy', to: 'static_pages#privacy_policy'
  resources :users, only: [:index, :edit, :update, :show]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
