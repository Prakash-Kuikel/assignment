# frozen_string_literal: true

module Types
  class PostInputType < GraphQL::Schema::InputObject
    graphql_name 'PostInputType'

    argument :id, ID, required: false
    argument :user_id, ID, required: false
    argument :body, String, required: false
  end
end
