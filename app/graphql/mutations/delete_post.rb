class Mutations::DeletePost < GraphQL::Schema::Mutation
  null true
  argument :post_id, ID, required: true
  type Boolean
  def resolve(post_id:)
    return GraphQL::ExecutionError.new("Post not found") unless Post.exists?(id: post_id,
                                                                             user_id: context[:current_user][:id])

    return Post.find(post_id).destroy
  end
end
