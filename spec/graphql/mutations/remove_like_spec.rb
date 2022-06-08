require "rails_helper"

RSpec.describe "Removing like from a post" do
  let(:current_user) { create :user }
  let(:valid_user) { create :user, email: "b@b", name: "Sonam" }
  let(:valid_post) { valid_user.posts.create body: "This is a valid post" }

  context "with valid postId" do
    context "if liked already" do
        it "returns true" do
            valid_post.likes.create user_id: current_user.id
            variable = { 
                        "postId": valid_post.id
                        }

            result = MiniTwitterSchema.execute(remove_like_query, variables: variable,
                                                            context: { current_user: current_user })

            expect(result.dig("data", "removeLike")).to eq(true)
        end
    end
    
    context "if not already liked" do
        it "raises error" do
            variable = { 
                        "postId": valid_post.id
                     }
    
            result = MiniTwitterSchema.execute(remove_like_query, variables: variable,
                     context: { current_user: current_user })
            
            expect(result["errors"][0]["message"]).to eq("You've not liked this post yet")
        end
      end
  end

  context "with invalid postId" do
    it "raises error" do
        variable = { 
                    "postId": 123
                 }

        result = MiniTwitterSchema.execute(remove_like_query, variables: variable,
                                                            context: { current_user: current_user })

        expect(result["errors"][0]["message"]).to eq("Post not found!")
    end
  end

  def remove_like_query
    <<~GQL
      mutation ($postId: ID!){
        removeLike(postId: $postId)
      }
    GQL
  end
end