Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # You can have the root of your site routed with "root"
  root 'topics#preview', as: :topics_preview

  # Session management
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  post 'logout' => 'sessions#destroy'

  # HACK for KB
  get 'logout' => 'sessions#destroy'

  # Chat
  resources :chat_sessions, path: 'chat', except: [:index]
  get 'chats' => 'chat_sessions#index', as: :chats
  get 'chats/archived' => 'chat_sessions#archived_list', as: :archived_chats
  patch 'chat/:id/start' => 'chat_sessions#start', as: :start_chat_session
  patch 'chat/:id/end' => 'chat_sessions#end', as: :end_chat_session
  patch 'chat/:id/notes' => 'chat_sessions#update_notes', as: :update_notes_for_chat_session

  # Chat
  get 'private_chats' => 'chat_sessions#index', as: :private_chats
  get 'private_chat/:id' => 'private_chat_sessions#show', as: :private_chat

  patch 'private_chat/:id/end' => 'private_chat_sessions#end', as: :end_private_chat_session
  post 'private_chat/:id/post' => 'private_chat_sessions#post', as: :post_to_private_chat_session

  # Chat messages
  post 'chat/:id/post' => 'chat_sessions#post', as: :post_to_chat_session

  # Topics
  resources :topics, path: 'forum'
  get 'forums/manage' => 'topics#manage', as: :topics_manage
  patch 'forums/manage' => 'topics#update_order'

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
  post 'user/:id/send_password_reset' => 'users#send_password_reset', as: :user_password_reset
  post 'user/:id/hide_activity' => 'users#hide_activity', as: :hide_user_activity
  post 'user/:id/suspend' => 'users#suspend', as: :suspend_user
  post 'user/:id/unsuspend' => 'users#unsuspend', as: :unsuspend_user

  patch 'user/:id/set_access_level' => 'users#set_access_level', as: :set_user_access_level
  patch 'user/:id/set_email' => 'users#set_email', as: :set_user_email
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

  # Community rules
  get 'community_rules' => 'community_rules#index'

  # resources :notifications
  get "notifications/history" => "notifications#history", as: :notifications_history
  get "notifications/new" => "notifications#new", as: :new_notification
  post "notifications/proof/:content_type" => "notifications#proof", as: :new_notification_proof
  post "notifications/create" => "notifications#create", as: :create_notification

  # API
  scope :api do
    get '' => 'api#index', as: :api
    get 'threads_for_tag/:tag' => 'api#threads_for_tag'
    get 'threads_for_query/:query' => 'api#threads_for_query'
    get 'sessions_for_tag/:tag' => 'api#sessions_for_tag'
    get 'sessions_for_query/:query' => 'api#sessions_for_query'
    get 'user' => 'api#current_user'
    get 'upcoming_chat' => 'api#upcoming_chat'
    get 'forums_overview' => 'api#forums_overview'
  end

  # Admin
  scope :admin do
    get '' => 'landing#admin', as: :admin

    resources :access_levels
  end
end
