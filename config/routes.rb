require 'sidekiq/web'
Sidekiq::Web.set :session_secret, Rails.application.secrets[:secret_key_base]

Rails.application.routes.draw do
  get 'login', to: 'sessions#new', as: :login
  match '/auth/mixin/callback', to: 'sessions#create', via: [:get, :post], as: :session
  match '/auth/failure', to: 'sessions#failure', via: :get
  delete '/logout', to: 'sessions#destroy', as: :logout

  resources :mx_apps, only: [:index, :new, :create, :show, :edit, :update, :destroy], param: :number
  resources :preview_mx_apps, only: [:show], param: :number

  # 应用管理
  resources :mx_apps, only: [], module: 'mx_apps', param: :number do
    namespace :store do
      resources :products, only: [:index, :new, :create, :edit, :update], param: :number
      resources :users, only: [:index, :show]
      resources :orders, only: [:index]
    end

    namespace :circle do
      resource  :basic_setting, only: [:edit, :update]
      resource  :limit_setting, only: [:edit, :update]
      resources :users, only: [:index, :show]
      resources :orders, only: [:index]
    end
  end

  # 用户视角的商店
  resources :stores, only: [], module: 'stores', param: :number do
    get 'login', to: 'sessions#new', as: :login
    match '/auth/mixin/callback', to: 'sessions#create', via: [:get, :post], as: :session
    match '/auth/failure', to: 'sessions#failure', via: :get
    delete '/logout', to: 'sessions#destroy', as: :logout

    namespace :pages, default: { format: :json } do
      resource 'home', only: [:show]
      resource 'category', only: [:show]
      resource 'cart', only: [:show]
      resource 'mine', only: [:show]
    end

    get '/', to: 'app#show', as: :root
  end

  # 用户视角的新圈子
  resources :circles, only: [], module: 'circles', param: :number do
    get 'login', to: 'sessions#new', as: :login
    match '/auth/mixin/callback', to: 'sessions#create', via: [:get, :post], as: :session
    match '/auth/failure', to: 'sessions#failure', via: :get
    delete '/logout', to: 'sessions#destroy', as: :logout

    get '/', to: 'home#index', as: :root

    resources :membership_orders, only: [:new, :create]
    resource :payment_state, only: [:show]

    resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
    end
    resources :loading_more_posts, only: [:index]
    resources :liked_posts, only: [:update, :destroy]
  end

  namespace :admin do
    get 'login', to: 'sessions#new', as: :login
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy', as: :logout
    resource :account, only: [:edit, :update]

    resources :users, only: [:index]

    root to: 'dashboard#index'
  end

  mount Sidekiq::Web => '/sidekiq'
  mount StatusPage::Engine => '/'
  #mount ActionCable.server => '/cable'
  root to: 'home#index'
end
