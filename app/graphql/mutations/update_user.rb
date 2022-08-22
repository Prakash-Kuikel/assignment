# frozen_string_literal: true

module Mutations
  class UpdateUser < GraphQL::Schema::Mutation
    null true
    argument :old_password, String, required: true
    argument :new_data, Types::UserInputType, required: true
    type Boolean

    def resolve(old_password:, new_data:)
      current_user = context[:current_user]
      return GraphQL::ExecutionError.new('Wrong password!') unless current_user.valid_password?(old_password)

      current_user.update new_data.to_h
    end
  end
end
