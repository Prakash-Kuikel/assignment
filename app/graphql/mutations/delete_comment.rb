class Mutations::DeleteComment < GraphQL::Schema::Mutation
  null true
  argument :comment_id, ID, required: true
  type Boolean
  def resolve(comment_id:)
    return GraphQL::ExecutionError.new("Comment not found") unless Comment.exists?(id: comment_id,
                                                                             user_id: context[:current_user][:id])

    return Comment.find(comment_id).destroy
  end

  # visible only if not currently logged in
  def self.visible?(context)
    !!context[:current_user]
  end
end
