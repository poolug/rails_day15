class LikesController < ApplicationController
  before_action :authenticate_user! # solo si usuario está logeado puede dar likes

  def like
    @tweet = Tweet.find(params[:tweet_id])
    new_like = Like.create!(tweet: @tweet, user: current_user)
    redirect_to root_path
  end

  def dislike
    tweet = Tweet.find(params[:tweet_id]) # busca el id del tweet
    like = tweet.likes.find_by(user: current_user) # busca el like del tweet
    if like == nil
      redirect_to root_path
    else
    like.destroy # destruye el like
    redirect_to root_path # redirección al root
    end
  end
end
