class Mutations::Register < GraphQL::Schema::Mutation
  null true
  argument :user, Types::UserInputType, required: true
  type Types::UserType
  def resolve(user:)
    User.create user.to_h
  end

  # visible only if not currently logged in
  def self.visible?(context)
    !context[:current_user]
  end
end
