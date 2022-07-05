Rails.application.routes.draw do
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "questions#index"

  resources :questions do
    resources :answers, except: %i[new show]
  end
end
