Rails.application.routes.draw do
  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # Session management
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  post 'logout' => 'sessions#destroy'

  resources :topics, path: 'topic'
  get 'forums' => 'topics#preview', as: :topics_preview
  get 'thread/:id' => 'topic_threads#show', as: :thread

  # Admin
  scope :admin do
    get '' => 'landing#admin', as: :admin

    resources :access_levels
  end
end
