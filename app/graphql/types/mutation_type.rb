module Types
  class MutationType < Types::BaseObject
    field :login, mutation: Mutations::Login
    field :register, mutation: Mutations::Register
    field :create_post, mutation: Mutations::CreatePost
    field :update_user, mutation: Mutations::UpdateUser
    field :update_post, mutation: Mutations::UpdatePost
    field :delete_user, mutation: Mutations::DeleteUser
    field :delete_post, mutation: Mutations::DeletePost
    field :logout, mutation: Mutations::Logout
    field :follow, mutation: Mutations::Follow
    field :create_comment, mutation: Mutations::CreateComment 
    field :delete_comment, mutation: Mutations::DeleteComment
  end
end
