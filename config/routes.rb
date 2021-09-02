Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root 'tweets#index'
  resources 'tweets'
  post 'tweets/retweets/:id', to: 'tweets#retweets', as: 'retweets'
  post 'tweets/:tweet_id/likes', to: 'likes#like', as: 'like'
  post 'tweets/:tweet_id/dislikes', to: 'likes#dislike', as: 'dislike'
  post 'follows/:id', to: 'follows#to_follow', as: 'follow'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
