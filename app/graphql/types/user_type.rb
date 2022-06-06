class Types::UserType < Types::BaseObject
  field :id, ID, null: true
  field :name, String, null: true
  field :email, String, null: true
  field :authentication_token, String, null: true

  field :posts, [Types::PostType], null: true, description: "Display all posts of user"
end
