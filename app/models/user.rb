class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :follower_users, foreign_key: :follower_id, class_name: "Friendship"
  has_many :followees, through: :follower_users

  has_many :followee_users, foreign_key: :followee_id, class_name: "Friendship"
  has_many :followers, through: :followee_users

end
