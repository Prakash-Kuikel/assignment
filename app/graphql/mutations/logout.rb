class Mutations::Logout < GraphQL::Schema::Mutation
    
    null true

    def resolve
        current_user = context[:current_user]

        if current_user.present?
            current_user.reset_authentication_token!
            return true
        else
          GraphQL::ExecutionError.new("User not signed in")
        end
    end

end