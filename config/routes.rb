Rails.application.routes.draw do
  
  root to: 'staticpages#top'
  
  resources :users, only: %i[new create]
  resources :posts
  resources :boards do
    resources:comments, only: %i[create destroy updete], shallow: true
  end

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
 
end
