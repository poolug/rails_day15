class TweetsController < ApplicationController
  def index
    @tweets = Tweet.limit(50)
    @tweet = Tweet.new
    if user_signed_in?
      render :index
    else
      redirect_to new_user_registration_path
    end
  end

  def create
    @tweet = Tweet.new(content: params[:tweet][:content])
    @tweet.user = current_user
    respond_to do |format|
      if @tweet.save
        format.html { redirect_to root_path, notice: "¡Tweet creado con éxito!" }
      else
        format.html { render :index }
      end
    end 
  end
  
  def retweets
    @tweet = Tweet.find(params[:id])
    new_tweet = Tweet.create(content: @tweet.content, user: current_user)
    @tweet.retweets << new_tweet
    redirect_to root_path
  end
  

end
