
Rails.application.routes.draw do
  devise_for :users
  resources :blog_posts
  root to: "blog_posts#index"
end