require "rails_helper"

RSpec.describe "Registering a new user" do
  context "with valid input" do
    it "creates new user and returns id" do
      variable = { "user": { "name": "Sonam Wangmo", "email": "sonam@gmail.com", "password": "12345678",
                             "passwordConfirmation": "12345678" } }

      result = MiniTwitterSchema.execute(create_user_query, variables: variable)

      expect(result.dig("data", "register", "authenticationToken")).to be_present
    end
  end

  context "with invalid input" do
    it "returns null" do
      variable = { "user": { "name": "Sonam Wangmo", "email": "sonam@gmail.com", "password": "12345678",
                             "passwordConfirmation": "321" } }

      result = MiniTwitterSchema.execute(create_user_query, variables: variable)

      expect(result.dig("data", "createUser", "id")).to be_blank
    end
  end

  def create_user_query
    <<~GQL
      mutation($user:UserInputType!){
          register(user: $user){
              authenticationToken
          }
      }
    GQL
  end
end
