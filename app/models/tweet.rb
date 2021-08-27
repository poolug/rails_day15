class Tweet < ApplicationRecord
    validates :content, presence: true
    belongs_to :user
    has_many :likes
    # relación recursirva para hacer retweets
    has_many :retweets, class_name: "Tweet", foreign_key: "tweet_id", dependent: :destroy
    belongs_to :original_tweet, class_name: "Tweet", foreign_key: "tweet_id", optional: true

    paginates_per 1000
    
    def set_photo
        self.user.photo
    end

    def set_rt_count
        self.retweets.count
    end

    def set_user_name
        self.user.name
    end

    def set_likes_count
        self.likes.count
    end

    def set_origin_photo
        Tweet.find(self.tweet_id).user.photo
    end

    def set_origin_user
        Tweet.find(self.tweet_id).user.name
    end
    
    def set_origin_content
        Tweet.find(self.tweet_id).content
    end
    
    def set_origin_date
        Tweet.find(self.tweet_id).created_at
    end
    
end
