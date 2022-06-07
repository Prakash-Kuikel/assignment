class Types::PostType < Types::BaseObject
  field :id, ID, null: true
  field :body, String, null: true
  field :created_at, String, null: true

  field :comments, [Types::CommentType], null: true
end
