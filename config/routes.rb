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
  
  concern :select do
    collection do
      post :select
    end
  end

  concern :select_season do
    member do
      post :select_season
      get '/:season_id', action: :show, as: 'show_season'
    end    
  end
  
  concern :players do
    resources :players, only: [:index]
  end

  resources :countries, only: [:index, :show], concerns: [:players]
  resources :players, only: [:index, :show], concerns: [:select_season]
  resources :teams, only: [:index, :show], concerns: [:select_season, :select]
  resources :seasons, only: [:index, :show], concerns: [:select]
    
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
end
