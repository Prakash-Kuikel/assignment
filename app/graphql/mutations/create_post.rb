# frozen_string_literal: true

module Mutations
  class CreatePost < GraphQL::Schema::Mutation
    null true
    argument :post, Types::PostInputType, required: true
    type Types::PostType

    def resolve(post:)
      user = context[:current_user]
      user.posts.create(body: post[:body])
    end
  end
end
