module Types
  class MutationType < Types::BaseObject
    
    field :login, Types::UserType, mutation: Mutations::Login
      
    field :register, Types::UserType, mutation: Mutations::Register

    field :create_post, Types::PostType, mutation: Mutations::CreatePost
      
    field :update_user, mutation: Mutations::UpdateUser
      
    field :update_post, mutation: Mutations::UpdatePost
      
    field :delete_user, mutation: Mutations::DeleteUser

    field :delete_post, mutation: Mutations::DeletePost
     
    field :logout, mutation: Mutations::Logout
    
  end
end
