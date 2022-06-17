require "rails_helper"

describe "Deleting a comment", type: :request do
  let(:user) { create :user }
  before { sign_in(user) }
  let(:valid_post) { user.posts.create body: "This is a valid post" }
  let(:valid_comment) { valid_post.comments.create user_id: user.id, comment: "This is a valid comment" }
 
  context "with valid commentID" do
    it "returns true" do
      variable = { "id": valid_comment[:id] }
      post graphql_path params: {query: delete_comment_query, variables: variable}
      expect(json.data.deleteComment).to eq(true)
      end
    end

  context "with invalid commentID" do
    it "returns error" do
      variable = { "id": 123 }
      post graphql_path params: {query: delete_comment_query, variables: variable}
      expect(json.errors[0]["message"]).to eq("Comment not found")
    end
  end

  def delete_comment_query
    <<~GQL
      mutation ($id: ID!){
          deleteComment(commentId: $id)
      }
    GQL
  end
end
