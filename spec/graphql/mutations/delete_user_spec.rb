require "rails_helper"

describe "Deleting user" do

    let(:valid_user) { User.create(email: "a@a", name: "pk", password:"12345678", password_confirmation: "12345678") }

    context "with valid UserID" do
        it "returns true" do
            variable = { "id": valid_user[:id] }
            result = MiniTwitterSchema.execute(delete_user_query, variables: variable)
        
            expect(result.dig("data", "deleteUser")).to eq(true)
        end
    end

    context "with invalid UserID" do
        it "returns error" do
            variable = { "id": 314 }

            expect{ MiniTwitterSchema.execute(delete_user_query, variables: variable) }.to raise_error(ActiveRecord::RecordNotFound)
        end
    end

    def delete_user_query 
        <<~GQL
            mutation ($id: ID!){
                deleteUser(id: $id)
            }
        GQL
    end
end