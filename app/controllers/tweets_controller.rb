class TweetsController < ApplicationController
  # solo si usuario está logeado puede acceder
  before_action :authenticate_user!, only: [ :retweets, :show ]
  
  def index
    if params[:q]
      # búsqueda parcial por el content del tweet
      @tweets = Tweet.where('content LIKE ?', "%#{params[:q]}%").order(created_at: :desc).page params[:page]
    elsif user_signed_in?
      @tweets = Tweet.tweets_for_me(current_user).order(created_at: :desc).page params[:page]
    else
      @tweets = Tweet.all.order(created_at: :desc).page params[:page]
      # @tweets = Tweet.eager_load(:user, :likes).order(created_at: :desc).page params[:page]
    end
    @tweet = Tweet.new
    @likes = Like.where(user: current_user).pluck(:tweet_id)
    @users = User.all
    # @users = User.where('id IS NOT ?', current_user.id).last(5) if user_signed_in? # Error en Heroku
    # @users = User.where.not(user_id, current_user.id).last(5) if user_signed_in?

  end

  def create
    @users = User.all
    @tweets = Tweet.all.order(created_at: :desc).page params[:page]
    @likes = Like.where(user: current_user).pluck(:tweet_id)
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
        format.html { redirect_to root_path, notice: "¡Haz hecho un RT éxito!" }
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
