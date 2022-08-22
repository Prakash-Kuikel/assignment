# frozen_string_literal: true

module Types
  class CommentType < Types::BaseObject
    field :id, ID, null: true
    field :user_id, ID, null: true
    field :comment, String, null: true
    field :created_at, GraphQL::Types::ISO8601Date, null: true
    field :post, Types::PostType, null: false
  end
end
