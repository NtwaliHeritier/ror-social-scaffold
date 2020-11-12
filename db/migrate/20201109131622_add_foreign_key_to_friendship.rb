class AddForeignKeyToFriendship < ActiveRecord::Migration[6.0]
  def change
    add_reference :friendships, :follower, references: :users, index: true
    add_foreign_key :friendships, :users, column: :follower_id 

    add_reference :friendships, :followee, references: :users, index: true
    add_foreign_key :friendships, :users, column: :followee_id 
  end
end
