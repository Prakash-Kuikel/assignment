class Types::UserType < Types::BaseObject

    field :id, ID, null: true
    field :name, String, null: true
    field :email, String, null: true

    field :post, [Types::PostType], null: true, description: "Display all posts of user"
    def post
        Post.where(user_id: object.id).all
    end

end

class Types::UserInputType < GraphQL::Schema::InputObject

    graphql_name "UserInputType"
       
    argument :id, ID, required: false
    argument :email, String, required: false
    argument :name, String, required: false
    argument :password, String, required: false
    argument :password_confirmation, String, required: false
    
end

