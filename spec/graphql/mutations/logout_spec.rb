require "rails_helper"

describe "Logging out" do
  let(:valid_user) { create :user }

  context "if currently logged in" do
    it "returns true" do
      result = MiniTwitterSchema.execute(logout_query, context: { current_user: valid_user })

      expect(result.dig("data", "logout")).to eq(true)
    end
  end

  context "if not logged in" do
    it "returns error" do
      result = MiniTwitterSchema.execute(logout_query, context: { current_user: nil })

      expect(result["errors"][0]["message"]).to eq("Field 'logout' doesn't exist on type 'Mutation'")
    end
  end

  def logout_query
    <<~GQL
      mutation{
          logout
      }
    GQL
  end
end
