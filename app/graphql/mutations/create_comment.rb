class Mutations::CreateComment < GraphQL::Schema::Mutation
    null true
    argument :post_id, ID, required: true
    argument :text, String, required: true
    type Types::CommentType
    def resolve(post_id:, text:)
        commenter_id = context[:current_user][:id]
        return GraphQL::ExecutionError.new("Post not found!") unless Post.exists?(post_id)
        Post.find(post_id).comments.create user_id: commenter_id, comment: text
    end

    # visible only if not currently logged in
    def self.visible?(context)
        !!context[:current_user]
    end
end