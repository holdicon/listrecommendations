Rails.application.routes.draw do
  
  devise_for :users

  resources :users, only: %i[index show]
  resources :lists, only: %i[index new create show edit destroy] do
    member do
      put "like", to: "lists#upvote"
      put "unlike", to: "lists#downvote"
    end
  end

  get 'users/:id/favorites', to: 'users#favorites', as: 'user_favorites'

  resources :recommendations, only: %i[show]
  resources :recommendations, only: %i[new],
  							  constraints: { format: :js } 

  resources :mobile_apps, only: %i[index] do
    resources :recommendations, only: %i[index new create]
  end

  root to: "static_pages#welcome"
  get "add_recommendation_form" => "lists#add_recommendation_form"

end
