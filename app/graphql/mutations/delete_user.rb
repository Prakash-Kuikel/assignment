class Mutations::DeleteUser < GraphQL::Schema::Mutation
  null true
  type Boolean
  def resolve
    User.find(context[:current_user][:id]).destroy
  end
end
