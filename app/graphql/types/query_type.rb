# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # field :current_user, Types::UserType, null: true, description: 'Display current user data, posts, and comments'
    # def current_user
    #   context[:current_user]
    # end

    field :feeds, [Types::PostType], null: true, description: 'Display posts of other users'
    def feeds
      Post.where(Post.arel_table[:user_id].not_eq(context[:current_user][:id])).all
    end
  end
end
