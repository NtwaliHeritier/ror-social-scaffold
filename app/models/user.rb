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

  has_many :sent_invitations, foreign_key: :invitor_id, class_name: "Invitation"
  has_many :invitees, through: :sent_invitations

  has_many :received_invitations, foreign_key: :invitee_id, class_name: "Invitation"
  has_many :invitors, through: :received_invitations

  # def request_sent(invitor, invitee)
  #   User.where("invitor_id = ? and invitee_id = ?", invitor, invitee)
  # end
end
