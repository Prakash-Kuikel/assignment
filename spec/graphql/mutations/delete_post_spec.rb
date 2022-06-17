require "rails_helper"

describe "Deleting a post", type: :request do
  let(:user) { create :user }
  before { sign_in(user) }
  let(:valid_post) do
    user.posts.create(body: "This is a valid post")
  end

  context "with valid PostID" do
    it "returns true" do
      variable = { "id": valid_post[:id] }
      post graphql_path params: {query: delete_post_query, variables: variable}
      expect(json.data.deletePost).to eq(true)
    end
  end

  context "with invalid PostID" do
    it "returns error" do
      variable = { "id": 314 }
      post graphql_path params: {query: delete_post_query, variables: variable}
      expect(json.errors[0]["message"]).to eq("Post not found")
    end
  end

  def delete_post_query
    <<~GQL
      mutation ($id: ID!){
          deletePost(postId: $id)
      }
    GQL
  end
end
