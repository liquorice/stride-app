Rails.application.routes.draw do
  # You can have the root of your site routed with "root"
  root 'topics#preview', as: :topics_preview

  # Session management
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  post 'logout' => 'sessions#destroy'

  # Topics
  resources :topics, path: 'forum'

  # Threads
  resources :topic_threads, path: 'thread'
  get 'threads/hidden' => 'topic_threads#hidden', as: :hidden_threads
  patch 'thread/:id/toggle_pin' => 'topic_threads#toggle_pin', as: :toggle_topic_thread_pin

  # Posts
  get 'post/:id' => 'posts#show', as: :post
  post 'thread/:id/post' => 'posts#new', as: :new_post
  patch 'post/:id/toggle_visibility' => 'posts#toggle_visibility', as: :toggle_post_visibility

  # Users
  get 'users' => 'users#index'
  get 'user/:id' => 'users#show', as: :user
  patch 'user/:id/set_access_level' => 'users#set_access_level', as: :set_user_access_level
  get 'preferences' => 'preferences#index'
  patch 'preferences' => 'preferences#update'
  patch 'preferences/password' => 'preferences#update_password', as: :update_password

  # New users
  get 'register' => 'users#register', as: :register
  post 'register' => 'users#signup'

  # Password resets
  get 'forgot' => 'password_requests#forgot'
  post 'forgot' => 'password_requests#send_password_reset'
  get 'reset_password/:token' => 'password_requests#reset', as: :password_reset
  post 'reset_password/:token' => 'password_requests#do_reset'

  # Admin
  scope :admin do
    get '' => 'landing#admin', as: :admin

    resources :access_levels
  end
end
