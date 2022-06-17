module Types
class UserInputType < GraphQL::Schema::InputObject
  graphql_name "UserInputType"

  argument :id, ID, required: false
  argument :email, String, required: false
  argument :name, String, required: false
  argument :password, String, required: false
  argument :password_confirmation, String, required: false
end
end