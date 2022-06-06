class Mutations::DeleteUser < GraphQL::Schema::Mutation
  null true
  type Boolean
  def resolve
    User.find(context[:current_user][:id]).destroy
  end

  # visible only if not currently logged in
  def self.visible?(context)
    !!context[:current_user]
  end
end
