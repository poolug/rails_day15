module Api
    module V1
        class TweetsController < V1Controller

            def by_dates
                # tweets = Tweet.find_by(created_at: params[:created_at])
                # # tweets = Tweet.where('DATE(created_at) = ?', params[:created_at])
                # tweets = Tweet.where('DATE(created_at) ? and ?', params[:created_at], params[:created_at])
                @date1 = params[:date1]
                @date2 = params[:date2]
                tweets = Tweet.where('DATE(created_at) > ? AND DATE(created_at) < ?', @date1, @date2)
                render json: tweets
            end

            def last_tweets
                @tweets = Tweet.last(50)
                last_tweets = @tweets.each do |tweet|
                    {
                        "id":  tweet.id,
                        "content": tweet.content,
                        "user_id": tweet.user_id,
                        "likes_count": Like.where(tweet_id: tweet.id).count,
                        "retweet_count": Tweet.where(tweet_id: tweet.id).count,
                        "retweeted_from": tweet.tweet_id
                    }
                end
                render json: last_tweets
            end

            def create
                @tweet = Tweet.create(content: [:content])
                render json: @tweet
            end
            
            
        end
    end
end