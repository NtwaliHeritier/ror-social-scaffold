class InvitationsController < ApplicationController
    def create
      @invitation = Invitation.new 
      @invitation.invitor_id = current_user.id
      @invitation.invitee_id = params[:user_id]
      @invitation.save
      redirect_to users_path
    end
    def index
      @invitations = current_user.received_invitations
    end
end
