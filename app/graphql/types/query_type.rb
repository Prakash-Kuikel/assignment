# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    mount_query Resolver::Posts
  end
end
