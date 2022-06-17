require "rails_helper"

RSpec.describe "Updating User details", type: :request do
  let(:user) { create :user }
  before { sign_in(user) }
  context "with correct old password" do
    it "returns true" do
      variable = {
        "old_pwd": "123456",
        "user": {
          "email": "edited@gmail.com",
          "name": "edited",
          "password": "edited123",
          "passwordConfirmation": "edited123"
        }
      }
      post graphql_path params: {query: update_user_query, variables: variable}
      expect(json.data.updateUser).to eq(true)
      
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

      post graphql_path params: {query: update_user_query, variables: variable}
      expect(json.errors[0]["message"]).to eq("Wrong password!")
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
