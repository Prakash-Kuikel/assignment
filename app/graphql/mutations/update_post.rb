class Mutations::UpdatePost < GraphQL::Schema::Mutation
  null true
  argument :post, Types::PostInputType, required: true
  type Boolean
  def resolve(post:)
    return GraphQL::ExecutionError.new("Post not found") unless Post.exists?(id: post[:id],
                                                                             user_id: context[:current_user][:id])

    return Post.find(post[:id]).update post.to_h
  end

  # visible only if currently logged in
  def self.visible?(context)
    !!context[:current_user]
  end
end
