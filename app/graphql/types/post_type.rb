class Types::PostType < Types::BaseObject

    field :body, String, null: true
    field :created_at, String, null: true

end

class Types::PostInputType < GraphQL::Schema::InputObject

    graphql_name "postInputType"

    argument :id, ID, required: false
    argument :user_id, ID, required: false
    argument :body, String, required: false

end