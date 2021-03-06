class CreateInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :invitations do |t|

      t.timestamps
    end
    add_reference :invitations, :invitor, references: :users, index: true
    add_foreign_key :invitations, :users, column: :invitor_id 

    add_reference :invitations, :invitee, references: :users, index: true
    add_foreign_key :invitations, :users, column: :invitee_id 
  end
end
