class Mutations::UpdateUser < GraphQL::Schema::Mutation

    null true

    argument :user, Types::UserInputType, required: true
    
    def resolve(user:)
        existing_user = User.find(user[:id])
        existing_user.update user.to_h
    end

end
