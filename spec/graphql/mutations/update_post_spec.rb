require "rails_helper"

RSpec.describe "Updating Post", type: :request do
  let(:user) { create :user }
  before { sign_in(user) }
  let(:valid_post) do
    user.posts.create(body: "This is a valid post")
  end

  context "with valid postID" do
    it "returns true" do
      variable = {
        "post": {
          "id": valid_post[:id],
          "body": "Updated body",
        }
      }
      post graphql_path params: {query: update_post_query, variables: variable}
      expect(response_body_json.data.updatePost).to eq(true)
    end
  end

  context "with invalid userID" do
    it "returns error" do
      variable = {
        "post": {
          "id": 431,
          "body": "Updated body",
        }
      }
      post graphql_path params: {query: update_post_query, variables: variable}
      expect(response_body_json.errors[0]["message"]).to eq("Post not found")
    end
  end

  def update_post_query
    <<~GQL
      mutation ($post: PostInputType!){
          updatePost(post: $post)
      }
    GQL
  end
end
