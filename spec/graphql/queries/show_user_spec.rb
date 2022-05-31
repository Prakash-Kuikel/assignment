require "rails_helper"

RSpec.describe "Show user" do
    let(:valid_user){ User.create(email: "a@a", name: "pk", password:"12345678", password_confirmation: "12345678") }

    context "with valid id" do
        it "shows user details and his/her posts" do
            result = MiniTwitterSchema.execute(show_user_query, variables: {id: valid_user[:id]})

            expect(result.dig("data", "showUser", "email")).to eq(String(valid_user[:email]))
            expect(result.dig("data", "showUser", "name")).to eq(String(valid_user[:name]))
        end
    end

    context "with invalid id" do
        it "returns error" do
            expect{ MiniTwitterSchema.execute(show_user_query, variables: {id: 123}) }.to raise_error(ActiveRecord::RecordNotFound)
        end
    end

    def show_user_query 
        <<~GQL
            query ($id: ID!){
                showUser(id: $id){
                    id,
                    email,
                    name,
                    post{
                        body,
                        createdAt
                    }
                }
            }
        GQL
    end
end