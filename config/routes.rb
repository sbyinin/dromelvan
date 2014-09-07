Rails.application.routes.draw do

  root to: 'home#index'

  get '/rules' => 'home#rules'
  get '/about' => 'home#rules'
  
  get '/search' => 'search#search'
  get '/live_search' => 'search#live_search'

  devise_for :users, skip: :registrations, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  devise_scope :user do
    resource :registration,
      only: [:new, :create, :edit, :update],
      path: 'users',
      path_names: { new: 'sign_up' },
      controller: 'devise/registrations',
      as: :user_registration do
        get :cancel
      end  
  end

  concern :players do
    resources :players, only: [:index]
  end

  resources :countries, only: [:index, :show], concerns: [:players]
  resources :players, only: [:index, :show]

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
end
