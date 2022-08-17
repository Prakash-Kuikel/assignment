require "rails_helper"

describe "Deleting a comment" do
  let(:current_user) { create :user }
  let(:valid_post) { current_user.posts.create body: "This is a valid post" }
  let(:valid_comment) { valid_post.comments.create user_id: current_user.id, comment: "This is a valid comment" }
 
  context "with valid commentID" do
    it "returns true" do
      variable = { "id": valid_comment[:id] }
      result = MiniTwitterSchema.execute(delete_comment_query, variables: variable,
                                                         context: { current_user: current_user })

      expect(result.dig("data", "deleteComment")).to eq(true)
      end
    end

  context "with invalid commentID" do
    it "returns error" do
      variable = { "id": 123 }
      result = MiniTwitterSchema.execute(delete_comment_query, variables: variable,
                                                            context: { current_user: current_user })

      expect(result["errors"][0]["message"]).to eq("Comment not found")
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
