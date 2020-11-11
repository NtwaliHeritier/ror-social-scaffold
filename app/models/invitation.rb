class Invitation < ApplicationRecord
  belongs_to :invitor, class_name: "User"
  belongs_to :invitee, class_name: "User"

  def self.invitation_exists?(invitor_id, invitee_id)
    Invitation.where("(invitor_id=? and invitee_id=?) or (invitee_id=? and invitor_id=?)", invitor_id, invitee_id, invitee_id, invitor_id).first
  end
end
