# frozen_string_literal: true

module Types
  class FollowingType < Types::BaseObject
    field :following_id, Int, null: true
    field :following_name, String, null: true

    def following_name
      User.find(object.following_id).name
    end
  end
end
