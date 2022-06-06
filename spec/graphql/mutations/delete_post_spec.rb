require "rails_helper"

describe "Deleting a post" do
  let(:current_user) do
    User.create(email: "a@a", name: "pk", password: "12345678", password_confirmation: "12345678")
  end
  let(:valid_post) do
    current_user.posts.create(body: "This is a valid post")
  end

  context "without logging in" do
    it "returns error" do
      variable = { "id": valid_post[:id] }
      result = MiniTwitterSchema.execute(delete_post_query, variables: variable, context: { current_user: nil })

      expect(result["errors"][0]["message"]).to eq("Field 'deletePost' doesn't exist on type 'Mutation'")
    end
  end

  context "while logged in" do
    context "with valid PostID" do
      it "returns true" do
        variable = { "id": valid_post[:id] }
        result = MiniTwitterSchema.execute(delete_post_query, variables: variable,
                                                              context: { current_user: current_user })

        expect(result.dig("data", "deletePost")).to eq(true)
      end
    end

    context "with invalid PostID" do
      it "returns error" do
        variable = { "id": 314 }
        result = MiniTwitterSchema.execute(delete_post_query, variables: variable,
                                                              context: { current_user: current_user })

        expect(result["errors"][0]["message"]).to eq("Post not found")
      end
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
