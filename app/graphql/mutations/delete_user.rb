class Mutations::DeleteUser < GraphQL::Schema::Mutation
  null true
  argument :old_password, String, required: true
  type Boolean
  def resolve(old_password:)
    current_user = context[:current_user]
    return GraphQL::ExecutionError.new("Wrong password!") unless current_user.valid_password?(old_password)
    User.find(current_user.id).destroy
  end
end
