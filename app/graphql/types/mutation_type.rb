module Types
  class MutationType < Types::BaseObject
    
    field :sign_in, Types::UserType, mutation: Mutations::Login
      
    field :register, Types::UserType, mutation: Mutations::Register

    field :create_post, Types::PostType, mutation: Mutations::CreatePost
      
    field :update_user, Boolean, mutation: Mutations::UpdateUser
      
    field :update_post, Boolean, mutation: Mutations::UpdatePost
      
    field :delete_user, Boolean, mutation: Mutations::DeleteUser

    field :delete_post, Boolean, mutation: Mutations::DeletePost
     
    field :logout, Boolean, null: true
    def logout
      current_user = context[:current_user]

      if current_user.present?
          current_user.reset_authentication_token!
          return true
      else
        GraphQL::ExecutionError.new("User not signed in")
      end
    end
    
  end
end
