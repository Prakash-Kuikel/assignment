# frozen_string_literal: true

module Mutations
  class DeleteComment < GraphQL::Schema::Mutation
    null true
    argument :comment_id, ID, required: true
    type Boolean
    def resolve(comment_id:)
      comment = Comment.find(comment_id)
      comment.destroy!
    end
  end
end
