class TweetsController < ApplicationController
  before_action :authenticate_user!, only: [ :retweets, :show ] # solo si usuario está logeado puede hacer retweets
  
  def index
    # @tweets = Tweet.limit(50)
    @tweet = Tweet.new
    @tweets = Tweet.all.page params[:page]
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
  
  def show
    @tweets = Tweet.find(params[:id])
  end

end
