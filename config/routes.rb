Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  # PostsController
  get 'posts/new', to: 'posts#new', as: 'new_post'
  get '/', to: 'posts#index', as: 'index_post'
  # この行を追加
  post 'posts/new', to: 'posts#create', as: 'create_post'
  
  # TopicsController
  get 'topics/new', to: 'topics#new', as: 'new_topic'
  get 'topics/edit/:id', to: 'topics#edit', as: 'edit_topic'
  # 2-9:課題3
  post 'topics/new', to: 'topics#create', as: 'create_topic'
  # 2-9:課題６
  post 'topics/edit', to: 'topics#update', as: 'update_topic'
  
end
