Rails.application.routes.draw do

  root to: 'home#index'

  get '/rules' => 'home#rules'
  get '/about' => 'home#about'
  
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

  concern :table do
    collection do
      post :select_table
    end
    member do
      get :show_table, path: 'table'
    end
  end
  
  concern :status_enum do
    member do
      get :pend
      get :activate
      get :finish
    end    
  end
  
  concern :players do
    resources :players, only: [:index]
  end

  resources :countries, only: [:index, :show], concerns: [:players]
  resources :seasons, only: [:index, :show], concerns: [:select]
  resources :teams, only: [:index, :show], concerns: [:select_season, :select]
  resources :players, only: [:index, :show], concerns: [:select_season]
  resources :premier_leagues, only: [:show], concerns: [:select, :table], path: 'premier-leagues'
  resources :match_days, only: [:show, :update], concerns: [:select, :status_enum], path: 'match-days'
  resources :matches, only: [:show, :update], concerns: [:select, :status_enum]
  resources :d11_leagues, only: [:show], concerns: [:select, :table], path: 'd11-leagues'
  resources :d11_match_days, only: [:show, :update], concerns: [:select], path: 'd11-match-days'
  resources :d11_matches, only: [:show], concerns: [:select], path: 'd11-matches'
  resources :d11_teams, only: [:index, :show], concerns: [:select_season, :select], path: 'd11-teams'
  resources :transfer_windows, only: [:show], concerns: [:select], path: 'transfer-windows'
  resources :transfer_days, only: [:show], concerns: [:select], path: 'transfer-days'
  resources :team_table_stats, only: [:index]
  resources :d11_team_table_stats, only: [:index]
  resources :posts, except: [:destroy]
    
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
end
