class AddRetweetToTweet < ActiveRecord::Migration[5.2]
  def change
    add_reference :tweets, :tweet, foreign_key: true
  end
end
