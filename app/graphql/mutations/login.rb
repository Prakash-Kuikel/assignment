class Mutations::Login < GraphQL::Schema::Mutation
  null true

  argument :email, String, required: true
  argument :password, String, required: true

  type Types::UserType
  def resolve(email:, password:)
    user = User.find_for_database_authentication(email: email)
    if user.present?
      return GraphQL::ExecutionError.new("Incorrect Password") unless user.valid_password?(password)

      return user
    else
      return GraphQL::ExecutionError.new("User not registered on this application")
    end
  end

  # visible only if not currently logged in
  def self.visible?(context)
    !context[:current_user]
  end
end
