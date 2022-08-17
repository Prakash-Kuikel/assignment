require "rails_helper"

describe "Deleting user", type: :request do
  let(:user) { create :user }
  
  context "without logging in" do
    it "returns error" do
      post graphql_path params: {query: delete_user_query}
      expect(status).to eq(302)
      expect(response.body).to include("You are being <a href=\"http://www.example.com/users/sign_in\">redirected")
    end
  end

  context "while logged in" do
    it "returns true" do
      sign_in(user)
      post graphql_path params: {query: delete_user_query}
      expect(json.data.deleteUser).to eq(true)
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
