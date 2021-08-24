class LikesController < ApplicationController
  def like
    @tweet = Tweet.find(params[:tweet_id])
    new_like = Like.create!(tweet: @tweet, user: current_user)
    redirect_to root_path
  end

  def dislike
  end
end
