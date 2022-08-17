require "rails_helper"

RSpec.describe "Creating a comment" do
  let(:current_user) { create :user }
  let(:valid_user) { create :user, email: "b@b", name: "Sonam" }
  let(:valid_post) { valid_user.posts.create body: "This is a valid post" }

  context "with valid postId" do
    it "creates comment and returns commentID" do
      variable = { 
                    "postId": valid_post.id,
                    "text": "This is a comment" 
                 }

      result = MiniTwitterSchema.execute(create_comment_query, variables: variable,
                                                            context: { current_user: current_user })

      expect(result.dig("data", "createComment", "id")).to be_present
      expect(result.dig("data", "createComment", "comment")).to eq("This is a comment")
      expect(result.dig("data", "createComment", "userId")).to eq(String(current_user.id))
    end
  end

  context "with invalid postId" do
    it "raises error" do
        variable = { 
                    "postId": 123,
                    "text": "This is a comment" 
                 }

        result = MiniTwitterSchema.execute(create_comment_query, variables: variable,
                                                            context: { current_user: current_user })

        expect(result["errors"][0]["message"]).to eq("Post not found!")
    end
  end

  def create_comment_query
    <<~GQL
      mutation ($postId: ID!, $text: String!){
        createComment(postId: $postId, text: $text){
            id
            comment
            userId
        }
      }
    GQL
  end
end