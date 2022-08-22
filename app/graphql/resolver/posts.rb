# frozen_string_literal: true

module Resolver
  class Posts < Resolver::BaseResolver
    argument :params, ::Attributes::Posts, required: false
    type [Types::PostType], null: false

    def resolve(params: {})
      Resolver::PostsQuery.new(current_user: User.first, params: params.to_h).call
    end
  end
end
