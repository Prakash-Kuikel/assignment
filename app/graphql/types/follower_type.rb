# frozen_string_literal: true

module Types
  class FollowerType < Types::BaseObject
    field :follower_id, Int, null: true

    def follower_id
      object.user_id
    end

    field :follower_name, String, null: true
    def follower_name
      User.find(object.user_id).name
    end
  end
end
