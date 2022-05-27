class Types::UserType < Types::BaseObject

    field :name, String, null: true
    field :email, String, null: true

    field :post, [Types::PostType], null: true, description: "Display all posts of user"
    def post
        Post.where(user_id: object.id).all
    end
end