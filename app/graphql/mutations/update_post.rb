class Mutations::UpdatePost < GraphQL::Schema::Mutation

    null true

    argument :post, Types::PostInputType, required: true
  
    def resolve(post:)
      existing_post = Post.find(post[:id])
      existing_post.update post.to_h
    end

end
