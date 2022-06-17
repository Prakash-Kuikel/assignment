module Types
class PostType < Types::BaseObject
  field :id, ID, null: true
  field :body, String, null: true
  field :user_id, ID, null: true
  field :created_at, String, null: true
  field :comments, [Types::CommentType], null: true
  field :likes, Integer, null: true
  def likes
    Like.where(post_id: object.id).all.count
  end
end
end