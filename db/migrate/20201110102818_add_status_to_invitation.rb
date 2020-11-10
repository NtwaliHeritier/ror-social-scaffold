class AddStatusToInvitation < ActiveRecord::Migration[6.0]
  def change
    add_column :invitations, :status, :boolean, default: true
  end
end
