class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tweets
  has_many :relationships
  has_many :friends, through: :relationships

  # Follower can see they are following someone. Followed can see they have a follower.
  has_many :inverse_relationships, :class_name => "Relationship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_relationships, :source => :user
  has_many :likes

  def likes?(tweet)
    tweet.likes.where(user_id: id).any?
  end

  validates :username, presence: true, uniqueness: true
end
