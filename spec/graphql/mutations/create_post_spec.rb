require "rails_helper"

RSpec.describe "Creating a post" do
  let(:current_user) { User.create(email: "a@a", name: "pk", password: "12345678", password_confirmation: "12345678") }

  context "if logged in" do
    it "creates post and returns postID" do
      variable = { "post": { "body": "hello" } }
      result = MiniTwitterSchema.execute(create_post_query, variables: variable,
                                                            context: { current_user: current_user })

      expect(result.dig("data", "createPost", "id")).to be_present
      expect(result.dig("data", "createPost", "body")).to eq("hello")
    end
  end

  def create_post_query
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
