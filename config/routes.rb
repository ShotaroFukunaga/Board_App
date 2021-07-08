Rails.application.routes.draw do
  
  root to: 'staticpages#top'
  resource :profile, only: %i[show edit update]
  
  resources :users, only: %i[new create]
  resources :posts
  resources :boards do
    resources :comments, only: %i[create destroy update], shallow: true
    collection do
      get :bookmarks
    end
  end
  resources :bookmarks, only: %i[create destroy]
  resources :password_resets, only: %i[new create edit update]

  namespace :admin do
    root to: 'dashboards#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
  end

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
