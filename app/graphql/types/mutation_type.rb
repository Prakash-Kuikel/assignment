module Types
  class MutationType < Types::BaseObject
    
    field :create_user, Types::UserType, null: true, description: "Create new user" do
      argument :user, Types::UserInputType, required: true
    end
    def create_user(user:)
      User.create user.to_h
    end  

    field :create_post, Types::PostType, null: true, description: "Create new post" do
      argument :post, Types::PostInputType, required: true
    end
    def create_post(post:)
      Post.create post.to_h
    end

    field :update_user, Boolean, null: true, description: "Update user details" do
      argument :user, Types::UserInputType, required: true
    end
    def update_user(user:)
      existing_user = User.find(user[:id])
      existing_user.update user.to_h
    end

    field :update_post, Boolean, null: true, description: "Update post" do
      argument :post, Types::PostInputType, required: true
    end
    def update_post(post:)
      existing_post = Post.find(post[:id])
      existing_post.update post.to_h
    end

    field :delete_user, Boolean, null: true, description: "Delete user and associated posts" do
      argument :id, ID, required: true
    end
    def delete_user(id:)
      user = User.find(id)
      user.destroy
      posts = Post.where(user_id: id).all
      posts.destroy_all
    end

    field :delete_post, Boolean, null: true, description: "Delete a particular post" do
      argument :post_id, ID, required: true
    end
    def delete_post(post_id:)
      post = Post.find(post_id)
      post.destroy
    end

  end
end
