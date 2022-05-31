module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :show_user, Types::UserType, null: true, description: "Display user details" do
      argument :id, ID, required: true
    end
    def show_user(id:)
      User.find(id)
    end


    field :login, String, null:true do
      argument :email, String, required: true
      argument :password, String, required: true
    end
    def login(email:, password:)
      user = User.where(email: email).first
      if user&.valid_password?(password)
        return user.authentication_token
      end
    end
    
  end
end
