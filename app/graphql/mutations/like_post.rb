# frozen_string_literal: true

module Mutations
  class LikePost < GraphQL::Schema::Mutation
    null true
    argument :post_id, ID, required: true
    type Boolean

    def resolve(post_id:)
      liker_id = context[:current_user][:id]

      Post.find(post_id).likes.create user_id: liker_id
    end
  end
end
