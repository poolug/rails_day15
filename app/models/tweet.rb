class Tweet < ApplicationRecord
    belongs_to :user
    has_many :likes
    # relación recursirva para hacer retweets
    has_many :retweets, class_name: "Tweet", foreign_key: "tweet_id", dependent: :destroy
    belongs_to :original_tweet, class_name: "Tweet", foreign_key: "tweet_id", optional: true
    
    validates :content, presence: true

end
