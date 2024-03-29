# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      # t.integer :user_id
      t.references :user, foreign_key: true
      t.string :body

      t.timestamps
    end
  end
end
