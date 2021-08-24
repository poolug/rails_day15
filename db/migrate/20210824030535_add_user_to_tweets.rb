class AddUserToTweets < ActiveRecord::Migration[5.2]
  def change
    add_reference :tweets, :user, foreign_key: true
  end
end
