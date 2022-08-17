class Mutations::RemoveLike < GraphQL::Schema::Mutation
    null true
    argument :post_id, ID, required: true
    type Boolean
    def resolve(post_id:)
        liker_id = context[:current_user][:id]
        return GraphQL::ExecutionError.new("Post not found!") unless Post.exists?(post_id)

        begin
            Like.find_by(post_id: post_id, user_id: liker_id).destroy
        rescue StandardError => e
            return GraphQL::ExecutionError.new("You've not liked this post yet")
        end
    end

    # visible only if not currently logged in
    def self.visible?(context)
        !!context[:current_user]
    end
end