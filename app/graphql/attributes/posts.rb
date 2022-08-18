module Attributes
  class Posts < Types::BaseInputObject
    argument :likes, Integer, required: false
    argument :created_at, ::GraphQL::Types::ISO8601Date, required: false
  end
end