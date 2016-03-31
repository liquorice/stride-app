Rails.application.routes.draw do
  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # Session management
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  post 'logout' => 'sessions#destroy'

  resources :topics, path: 'topic'
  get 'forums' => 'topics#preview', as: :topics_preview
  resources :topic_threads, path: 'thread'
  patch 'thread/:id/toggle_pin' => 'topic_threads#toggle_pin', as: :toggle_topic_thread_pin

  post 'thread/:id/post' => 'posts#new', as: :new_post
  patch 'post/:id/toggle_visibility' => 'posts#toggle_visibility', as: :toggle_post_visibility

  # Admin
  scope :admin do
    get '' => 'landing#admin', as: :admin

    resources :access_levels
  end
end
