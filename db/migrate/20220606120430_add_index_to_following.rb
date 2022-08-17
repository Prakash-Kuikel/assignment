class AddIndexToFollowing < ActiveRecord::Migration[6.1]
  def change
    add_index :followings, [:user_id, :following_id], unique: true
  end
end
