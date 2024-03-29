# frozen_string_literal: true

class CreateFollowing < ActiveRecord::Migration[7.0]
  def change
    create_table :followings do |t|
      t.references :user, foreign_key: true
      t.integer :following_id

      t.timestamps
    end

    add_index :followings, %i[user_id following_id], unique: true
    add_foreign_key :followings, :users, column: :following_id
  end
end
