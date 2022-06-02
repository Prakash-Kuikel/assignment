class Mutations::DeletePost < GraphQL::Schema::Mutation
    
    null true

    argument :post_id, ID, required: true

    type Boolean

    def resolve(post_id:)
        post = Post.find(post_id)
        post.destroy
    end

end