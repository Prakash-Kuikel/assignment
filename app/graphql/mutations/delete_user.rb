class Mutations::DeleteUser < GraphQL::Schema::Mutation
    
    null true

    argument :id, ID, required: true

    def resolve(id:)
      user = User.find(id)
      user.destroy
      posts = Post.where(user_id: id).all
      posts.destroy_all
    end

end