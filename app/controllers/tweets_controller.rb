class TweetsController < ApplicationController
  before_action :authenticate_user!, only: [ :retweets, :show ] # solo si usuario está logeado puede acceder
  
  def index
    if params[:q]
      @tweets = Tweet.where('content LIKE ?', "%#{params[:q]}%").order(created_at: :desc).page params[:page] # búsqueda parcial por el content del tweet
    else
      @tweets = Tweet.all.order(created_at: :desc).page params[:page]
    end
    @tweet = Tweet.new
    @likes = Like.where(user: current_user).pluck(:tweet_id)
  end

  def create
    @tweets = Tweet.all.order(created_at: :desc).page params[:page]
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
    @tweet = Tweet.find(params[:id])
    @tweet_likes = @tweet.likes
  end

end
