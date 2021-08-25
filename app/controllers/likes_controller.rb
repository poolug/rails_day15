class LikesController < ApplicationController
  before_action :authenticate_user! #solo usuario authentificado pueden dar Like

  def like
    @tweet = Tweet.find(params[:tweet_id])
    new_like = Like.create!(tweet: @tweet, user: current_user)
    redirect_to root_path
  end

  def dislike
    tweet = Tweet.find(params[:id])#busca el id del tweet
    like = tweet.likes.find_by(user: current_user)#se busca el like que comparta el tweet y el like
    like.destroy #destruye el like
    redirect_to root_path #dirreciona al root
  end
end
