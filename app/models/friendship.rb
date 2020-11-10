class Friendship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followee, class_name: "User"

  def self.accepted_request(followee_id)
    Friendship.where("status=? and followee_id=?", true, followee_id)
  end

  def self.request_confirmed(follower_id)
    Friendship.where("status=? and follower_id=?", true, follower_id)
  end
end
