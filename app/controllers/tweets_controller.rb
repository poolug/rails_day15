class TweetsController < ApplicationController
  before_action :authenticate_user!, only: [ :retweets, :show ] # solo si usuario está logeado puede hacer retweets
  
  def index
    # @tweets = Tweet.limit(50)
    @tweet = Tweet.new
    @tweets = Tweet.all.page params[:page]
  end

  def create
    @tweets = Tweet.all
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
    # new_tweet = Tweet.create(content: @tweet.content, user: current_user)
    # @tweet.retweets << new_tweet
    # redirect_to root_path

    @retweet = Tweet.new
    @retweet.content = @tweet.content
    @retweet.user_id = current_user.id
    @retweet.tweet_id = @tweet.id
    @retweet.created_at = DateTime.now
    @retweet.updated_at = DateTime.now

    respond_to do |format|
      if @retweet.save
        format.html { redirect_to root_path, notice: "¡RT creado con éxito!" }
      else
        format.html { render :index }
      end
    end

  end
  
  def show
    @tweets = Tweet.find(params[:id])
  end

end
