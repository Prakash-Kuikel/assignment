class Mutations::Register < GraphQL::Schema::Mutation
    
    null true

    argument :user, Types::UserInputType, required: true

    def resolve(user:)
        new_user = User.create user.to_h
    end 

end