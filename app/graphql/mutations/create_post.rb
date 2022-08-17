class Mutations::CreatePost < GraphQL::Schema::Mutation
  null true
  argument :post, Types::PostInputType, required: true
  type Types::PostType
  def resolve(post:)
    user = context[:current_user]
    user.posts.create(body: post[:body])
  end

  # visible only if not currently logged in
  def self.visible?(context)
    !!context[:current_user]
  end
end
