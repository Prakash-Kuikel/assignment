require "rails_helper"

RSpec.describe "Liking a post" do
  let(:current_user) { create :user }
  let(:valid_user) { create :user, email: "b@b", name: "Sonam" }
  let(:valid_post) { valid_user.posts.create body: "This is a valid post" }

  context "with valid postId" do
    context "if not liked already" do
        it "returns true" do
            variable = { 
                        "postId": valid_post.id
                        }

            result = MiniTwitterSchema.execute(like_post_query, variables: variable,
                                                            context: { current_user: current_user })

            expect(result.dig("data", "likePost")).to eq(true)
        end
    end
    
    context "if already liked" do
        it "raises error" do
            valid_post.likes.create user_id: current_user.id
            variable = { 
                        "postId": valid_post.id
                     }
    
            result = MiniTwitterSchema.execute(like_post_query, variables: variable,
                     context: { current_user: current_user })
            
            expect(result["errors"][0]["message"]).to eq("You've already liked this post")
        end
      end
  end

  context "with invalid postId" do
    it "raises error" do
        variable = { 
                    "postId": 123
                 }

        result = MiniTwitterSchema.execute(like_post_query, variables: variable,
                                                            context: { current_user: current_user })

        expect(result["errors"][0]["message"]).to eq("Post not found!")
    end
  end

  def like_post_query
    <<~GQL
      mutation ($postId: ID!){
        likePost(postId: $postId)
      }
    GQL
  end
end