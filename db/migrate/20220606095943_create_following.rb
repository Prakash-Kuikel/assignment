class CreateFollowing < ActiveRecord::Migration[6.1]
  def change
    create_table :followings do |t|
      t.integer :user_id
      t.integer :following_id

      t.timestamps
    end

    add_foreign_key :followings, :users, column: :following_id
  end
end
