class CreateFollowing < ActiveRecord::Migration[7.0]
  def change
    create_table :followings do |t|
      t.integer :user_id
      t.integer :following_id

      t.timestamps
    end

    add_foreign_key :followings, :users, column: :following_id
    add_index :followings, [:user_id, :following_id], unique: true
  end
end
