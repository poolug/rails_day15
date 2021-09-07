Rails.application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      get 'tweets/last', to: 'tweets#last_tweets'
      get 'tweets/:date1/:date2', to: 'tweets#by_dates'
      post 'tweets/newtweet', to: 'tweets#create'
      post 'users/sign_in', to: 'devise/sessions#create'
    end
  end
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
