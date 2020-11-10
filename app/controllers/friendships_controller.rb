class FriendshipsController < ApplicationController
  def create
    status = false
    @friendship = Friendship.new
    @friendship.follower_id = params[:invitor_id]
    @friendship.followee_id = current_user.id
    status = true if params[:commit] == "Accept"
    @friendship.status = status
    @friendship.save
    @invitation = Invitation.where("invitor_id = ? and invitee_id = ?", params[:invitor_id], current_user.id).first
    @invitation.update(status: false)
    redirect_to root_path
  end

  def index
    @friendships = []
    @status = ""
    if params[:commit].include?("Following")
      @friendships = Friendship.request_confirmed(params[:user_id])
      @status = "following"
    else
      @friendships = Friendship.accepted_request(params[:user_id])
      @status = "followers"
    end
  end
end
