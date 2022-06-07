require "rails_helper"

describe "Deleting user" do
  let(:current_user) { create :user }

  context "without logging in" do
    it "returns error" do
      result = MiniTwitterSchema.execute(delete_user_query, context: { current_user: nil })
      expect(result["errors"][0]["message"]).to eq("Field 'deleteUser' doesn't exist on type 'Mutation'")
    end
  end

  context "while logged in" do
    it "returns true" do
      result = MiniTwitterSchema.execute(delete_user_query, context: { current_user: current_user })
      expect(result.dig("data", "deleteUser")).to eq(true)
    end
  end

  def delete_user_query
    <<~GQL
      mutation{
          deleteUser
      }
    GQL
  end
end
