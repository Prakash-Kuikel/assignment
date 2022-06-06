require "rails_helper"

RSpec.describe "Updating User details" do
  let(:current_user) { User.create(email: "a@a", name: "pk", password: "12345678", password_confirmation: "12345678") }

  context "with correct old password" do
    it "returns true" do
      variable = {
        "old_pwd": "12345678",
        "user": {
          "email": "edited@gmail.com",
          "name": "edited",
          "password": "edited123",
          "passwordConfirmation": "edited123"
        }
      }
      result = MiniTwitterSchema.execute(update_user_query, variables: variable,
                                                            context: { current_user: current_user })

      expect(result.dig("data", "updateUser")).to eq(true)
    end
  end

  context "with incorrect old password" do
    it "returns error" do
      variable = {
        "old_pwd": "BAD",
        "user": {
          "email": "edited",
          "name": "edited",
          "password": "edited",
          "passwordConfirmation": "edited"
        }
      }

      result = MiniTwitterSchema.execute(update_user_query, variables: variable,
                                                            context: { current_user: current_user })

      expect(result["errors"][0]["message"]).to eq("Wrong password!")
    end
  end

  def update_user_query
    <<~GQL
      mutation ($user: UserInputType!, $old_pwd: String!){
          updateUser(oldPassword: $old_pwd, newData: $user)
      }
    GQL
  end
end
