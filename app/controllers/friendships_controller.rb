class FriendshipsController < ApplicationController
  def create
    following(params[:invitor_id], current_user.id)
    following(current_user.id, params[:invitor_id])
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

  private

  def following(arg1, arg2)
    status = false
    friendship = Friendship.new
    friendship.follower_id = arg1
    friendship.followee_id = arg2
    status = true if params[:commit] == "Accept"
    friendship.status = status
    friendship.save
    invitation = Invitation.where("invitor_id = ? and invitee_id = ?", arg1, arg2).first
    invitation&.update(status: false)
    # invitation.update(status: false) unless invitation.nil?
  end
end
