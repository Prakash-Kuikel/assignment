require "rails_helper"

RSpec.describe "Removing like from a post", type: :request do
  let(:user) { create :user }
  before { sign_in(user) }
  let(:valid_user) { create :user, email: "b@b", name: "Sonam" }
  let(:valid_post) { valid_user.posts.create body: "This is a valid post" }

  context "with valid postId" do
    context "if liked already" do
        it "returns true" do
            valid_post.likes.create user_id: user.id
            variable = { 
                        "postId": valid_post.id
                        }

            post graphql_path params: {query: remove_like_query, variables: variable}
            expect(json.data.removeLike).to eq(true)
        end
    end
    
    context "if not already liked" do
        it "raises error" do
            variable = { 
                        "postId": valid_post.id
                     }
    
            post graphql_path params: {query: remove_like_query, variables: variable}
            expect(json.errors[0]["message"]).to eq("You've not liked this post yet")
        end
      end
  end

  context "with invalid postId" do
    it "raises error" do
        variable = { 
                    "postId": 123
                 }

        post graphql_path params: {query: remove_like_query, variables: variable}
        expect(json.errors[0]["message"]).to eq("Post not found!")
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