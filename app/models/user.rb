class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  # seguidores
  has_many :followeds, class_name: 'Follow', foreign_key: :follower_id, dependent: :destroy
  # seguidos
  has_many :followers, class_name: 'Follow', foreign_key: :followed_id, dependent: :destroy
  validates :photo, presence: true

  def you_follow
    User.where.not(id: followeds.map(&:followed_id))
  end

end
