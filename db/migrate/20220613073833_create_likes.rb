# frozen_string_literal: true

class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.integer :post_id
      t.integer :user_id

      t.timestamps
    end

    add_index :likes, %i[user_id post_id], unique: true
  end
end
