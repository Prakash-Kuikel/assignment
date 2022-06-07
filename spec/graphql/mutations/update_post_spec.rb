require "rails_helper"

RSpec.describe "Updating Post" do
  let(:current_user) { create :user }
  let(:valid_post) do
    current_user.posts.create(body: "This is a valid post")
  end

  context "with valid postID" do
    it "returns true" do
      variable = {
        "post": {
          "id": valid_post[:id],
          "body": "Updated body",
        }
      }
      result = MiniTwitterSchema.execute(update_post_query, variables: variable,
                                                            context: { current_user: current_user })

      expect(result.dig("data", "updatePost")).to eq(true)
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
      result = MiniTwitterSchema.execute(update_post_query, variables: variable,
                                                            context: { current_user: current_user })
      expect(result["errors"][0]["message"]).to eq("Post not found")
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
