Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace "api" do
    namespace "v1" do
      resources :users
      post 'user_token', to: "user_token#create"
      resources :posts
    end
  end

end
