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
    before { sign_in(user) }
    context "with correct old password" do
      it "returns true" do
        variable = {"old_pwd": "123456"}
        post graphql_path params: {query: delete_user_query, variables: variable}
        expect(response_body_json.data.deleteUser).to eq(true)
      end
    end
    context "with invalid old password" do
      it "returns error" do
        variable = {"old_pwd": "BAD-PWD"}
        post graphql_path params: {query: delete_user_query, variables: variable}
        expect(response_body_json.errors[0]["message"]).to eq("Wrong password!")
      end
    end
  end

  def delete_user_query
    <<~GQL
      mutation($old_pwd: String!){
          deleteUser(oldPassword: $old_pwd)
      }
    GQL
  end
end
