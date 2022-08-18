# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: true
    field :name, String, null: true
    field :email, String, null: true
    field :authentication_token, String, null: true

    field :posts, [Types::PostType], null: true, description: 'Display all posts of user'

    field :followers, [Types::FollowerType], null: true, description: 'Show all followers'
    def followers
      Following.where(following_id: object.id).all
    end

    field :followings, [Types::FollowingType], null: true, description: 'Show users I follow'
  end
end
