Rails.application.routes.draw do

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users
    resources :courses do
      resources :lessons
    end
    root 'static_pages#landing_pages'
    get 'static_pages/activity'
    get 'privacy_policy', to: 'static_pages#privacy_policy'
    resources :users, only: [:index, :edit, :update, :show]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
