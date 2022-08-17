class Types::CommentType < Types::BaseObject
    field :id, ID, null: true
    field :user_id, ID, null: true
    field :comment, String, null: true
    field :created_at, String, null: true
end