require "rails_helper"

RSpec.describe "Creating a post", type: :request do
  
  let(:user) { create :user }
  before { sign_in(user) }
  
  context "if logged in" do
    it "creates post and returns postID" do
      var = { "post": { "body": "hello" } }
      post graphql_path params: {query: query, variables: var}
      
      expect(response_body_json.data.createPost.id).to be_present
      expect(response_body_json.data.createPost.body).to eq("hello")
    end
  end

  def query
    <<~GQL
      mutation ($post:PostInputType!){
        createPost(post: $post){
          id
          body
        }
      }
    GQL
  end
end
