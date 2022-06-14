module Types
  class MutationType < Types::BaseObject
    field :create_post, mutation: Mutations::CreatePost
    field :update_user, mutation: Mutations::UpdateUser
    field :update_post, mutation: Mutations::UpdatePost
    field :delete_user, mutation: Mutations::DeleteUser
    field :delete_post, mutation: Mutations::DeletePost
    field :follow, mutation: Mutations::Follow
    field :create_comment, mutation: Mutations::CreateComment 
    field :delete_comment, mutation: Mutations::DeleteComment
    field :like_post, mutation: Mutations::LikePost
    field :remove_like, mutation: Mutations::RemoveLike
  end
end
