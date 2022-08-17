require "rails_helper"

describe "Logging in" do
  let(:valid_user) { create :user }

  context "with valid credentials" do
    it "returns a token" do
      result = MiniTwitterSchema.execute(login_query, variables: {
                                           "email": valid_user[:email],
                                           "password": "123456"
                                         })

      expect(result.dig("data", "login", "authenticationToken")).to eq(valid_user[:authentication_token])
    end
  end

  context "with invalid credentials" do
    it "returns nil" do
      result = MiniTwitterSchema.execute(login_query, variables: {
                                           "email": valid_user[:email],
                                           "password": "bad-password"
                                         })

      expect(result.dig("data", "login")).to be_blank
    end
  end

  def login_query
    <<~GQL
      mutation($email: String!, $password: String!){
          login(email: $email, password: $password){
              authenticationToken
          }
      }
    GQL
  end
end
