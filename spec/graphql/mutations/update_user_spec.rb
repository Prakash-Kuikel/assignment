require "rails_helper"

RSpec.describe "Updating User details" do

    let(:valid_user){ User.create(email: "a@a", name: "pk", password:"123", password_confirmation: "123") }

    context "with valid userID" do
        it "returns true" do
            variable = {
                "user": {
                  "id":  valid_user[:id],
                  "email": "edited",
                  "name": "edited",
                  "password": "edited",
                  "passwordConfirmation": "edited"
                }
            }
            result = MiniTwitterSchema.execute(update_user_query, variables: variable)
            
            expect(result.dig("data", "updateUser")).to eq(true)
        end
    end

    context "with invalid userID" do
        it "returns error" do
            variable = {
                "user": {
                  "id":  231,
                  "email": "edited",
                  "name": "edited",
                  "password": "edited",
                  "passwordConfirmation": "edited"
                }
            }
            
            expect{ MiniTwitterSchema.execute(update_user_query, variables: variable) }.to raise_error(ActiveRecord::RecordNotFound)
        end
    end

    def update_user_query
        <<~GQL
            mutation ($user: UserInputType!){
                updateUser(user: $user)
            }
        GQL
    end
end