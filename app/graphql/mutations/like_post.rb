class Mutations::LikePost < GraphQL::Schema::Mutation
    null true
    argument :post_id, ID, required: true
    type Boolean
    def resolve(post_id:)
        liker_id = context[:current_user][:id]
        return GraphQL::ExecutionError.new("Post not found!") unless Post.exists?(post_id)

        begin
            Post.find(post_id).likes.create user_id: liker_id
        rescue StandardError => e
            return GraphQL::ExecutionError.new("You've already liked this post")
        end
    end
end