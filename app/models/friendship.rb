class Friendship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followee, class_name: "User"

  def self.accepted_request(followee_id)
    Friendship.where("status=? and followee_id=?", true, followee_id)
  end

  def self.request_confirmed(follower_id)
    Friendship.where("status=? and follower_id=?", true, follower_id)
  end

  def self.mutual_friends(user1, user2)
    friends1 = Friendship.where("follower_id=?", user1.id).pluck(:followee_id)
    friends2 = Friendship.where("follower_id=?", user2.id).pluck(:followee_id)
    User.where("id in (?)", friends1.select { |friend| friends2.include? friend })
  end

  def self.friendship_exists?(follower_id, followee_id)
    Friendship.where("(follower_id=? and followee_id=?) or (followee_id=? and follower_id=?)", follower_id, followee_id, followee_id, follower_id).first
  end
end
