Rails.application.routes.draw do
  # You can have the root of your site routed with "root"
  root 'topics#preview', as: :topics_preview

  # Session management
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  post 'logout' => 'sessions#destroy'

  # Topics
  resources :topics, path: 'topic'

  # Threads
  resources :topic_threads, path: 'thread'
  patch 'thread/:id/toggle_pin' => 'topic_threads#toggle_pin', as: :toggle_topic_thread_pin

  # Posts
  get 'post/:id' => 'posts#show', as: :post
  post 'thread/:id/post' => 'posts#new', as: :new_post
  patch 'post/:id/toggle_visibility' => 'posts#toggle_visibility', as: :toggle_post_visibility

  # Users
  get 'users' => 'users#index'
  get 'user/:id' => 'users#show', as: :user
  get 'preferences' => 'preferences#index'
  patch 'preferences' => 'preferences#update'
  patch 'preferences/password' => 'preferences#update_password', as: :update_password

  # New users
  get 'register' => 'users#register', as: :register
  post 'register' => 'users#signup'

  # Admin
  scope :admin do
    get '' => 'landing#admin', as: :admin

    resources :access_levels
  end
end
