Rails.application.routes.draw do
  devise_for :users
  
  resources :blog_posts do
    collection do
      get :manage_positions
      patch :update_positions
    end
  end
  
  root "blog_posts#index" # Set root to the login page

end