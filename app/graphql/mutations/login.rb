class Mutations::Login < GraphQL::Schema::Mutation

    null true

    argument :email, String, required: true
    argument :password, String, required: true
    
    def resolve(email: , password:)
      user = User.find_for_database_authentication(email: email)
      if user.present?
        if user.valid_password?(password)
          return user
        else
          GraphQL::ExecutionError.new("Incorrect Email/Password")
        end
      else
        GraphQL::ExecutionError.new("User not registered on this application")
      end
    end

end