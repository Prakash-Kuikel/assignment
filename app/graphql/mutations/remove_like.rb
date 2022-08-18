# frozen_string_literal: true

module Mutations
  class RemoveLike < GraphQL::Schema::Mutation
    null true
    argument :post_id, ID, required: true
    type Boolean
    def resolve(post_id:)
      liker_id = context[:current_user][:id]
      return GraphQL::ExecutionError.new('Post not found!') unless Post.exists?(post_id)

      begin
        Like.find_by(post_id:, user_id: liker_id).destroy
      rescue StandardError => e
        GraphQL::ExecutionError.new("You've not liked this post yet")
      end
    end
  end
end
