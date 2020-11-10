class FriendshipsController < ApplicationController
  def create 
    @friendship = Friendship.new
    @friendship.follower_id = params[:invitor_id]
    @friendship.followee_id = current_user.id
    @friendship.save
    @invitation = Invitation.where("invitor_id = ? and invitee_id = ?", params[:invitor_id], current_user.id).first
    @invitation.update(status: false)
    redirect_to root_path
  end
end
