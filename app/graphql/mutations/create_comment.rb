# frozen_string_literal: true

module Mutations
  class CreateComment < GraphQL::Schema::Mutation
    null true
    argument :post_id, ID, required: true
    argument :comment, String, required: true
    type Types::CommentType
    def resolve(post_id:, comment:)
      commenter_id = context[:current_user][:id]
      # return GraphQL::ExecutionError.new('Post not found!') unless Post.exists?(post_id)
      post = Post.find(post_id)
      post.comments.create(user_id: commenter_id, comment: comment)
    end
  end
end
