class Mutations::Follow < GraphQL::Schema::Mutation
    null true
    argument :user_id, ID, required: true
    type Boolean
    def resolve (user_id:)
        user = context[:current_user]
        user.followings.create following_id: user_id
    end

    # visible only if not currently logged in
    def self.visible?(context)
        !!context[:current_user]
    end
end