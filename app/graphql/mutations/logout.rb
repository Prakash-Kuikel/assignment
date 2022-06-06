class Mutations::Logout < GraphQL::Schema::Mutation
  null true
  type Boolean
  def resolve
    current_user = context[:current_user]
    return GraphQL::ExecutionError.new("User not signed in") unless current_user.present?

    current_user.reset_authentication_token!
  end

  # visible only if not currently logged in
  def self.visible?(context)
    !!context[:current_user]
  end
end
