class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followeds, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships,source: :follower

  def following?(other_user)
    followeds.include? other_user
  end

  def follow(other_user)
    followeds << other_user
  end

  def unfollow(other_user)
    followeds.destroy(other_user)
  end

  def feed
    followeds.pluck(:id) << self.id
    Tweet.where(user_id: followeds.pluck(:id)).order(created_at: :desc)
  end
end
