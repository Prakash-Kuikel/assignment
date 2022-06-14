require "rails_helper"

RSpec.describe "Creating a comment", type: :request do
  
  let(:user) { create :user }
  before { sign_in(user) }
  let(:another_user) { create :user, email: "b@b", name: "Sonam" }
  let(:other_user_post) { another_user.posts.create body: "This is a valid post" }

  context "with valid postId" do
    it "creates comment and returns commentID" do
      variable = { 
                    "postId": other_user_post.id,
                    "text": "This is a comment" 
                 }

      post graphql_path params: {query: query, variables: variable}

      expect(json.data.createComment.id).to be_present
      expect(json.data.createComment.comment).to eq("This is a comment")
      expect(json.data.createComment.userId).to eq(String(user.id))
    end
  end

  context "with invalid postId" do
    it "raises error" do
        variable = { 
                    "postId": 123,
                    "text": "This is a comment" 
                 }

        post graphql_path params: {query: query, variables: variable}
        expect(json.errors[0]["message"]).to eq("Post not found!")
    end
  end

  def query
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