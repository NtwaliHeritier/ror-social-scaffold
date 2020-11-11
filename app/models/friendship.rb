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
    common_friends = friends1.select{|friend| friends2.include?friend }
    arr=[]
    i=0
    while i<common_friends.length do
      arr.push(User.find(common_friends[i]))
      i+=1
    end
    arr
  end

end
