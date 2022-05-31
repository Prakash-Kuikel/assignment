require "rails_helper"

RSpec.describe "Creating a post" do
    let(:valid_user){ User.create(email: "a@a", name: "pk", password:"123", password_confirmation: "123") }

    context "with valid userID" do
        it "returns postID" do
            variable = { "post": { "userId": valid_user[:id], "body": "hello" } }
            result = MiniTwitterSchema.execute(create_post_query, variables: variable)

            expect(result.dig("data", "createPost", "id")).to eq(String(valid_user[:id]))
            expect(result.dig("data", "createPost", "body")).to eq("hello")
        end
    end 
    
    context "with invalid userID" do
        it "returns nil" do
            variable = { "post": { "userId": 312, "body": "hello" } }
            result = MiniTwitterSchema.execute(create_post_query, variables: variable)

            expect(result.dig("data", "createPost", "id")).to be_blank
        end
    end

    def create_post_query 
        <<~GQL
            mutation ($post:postInputType!){
                createPost(post: $post){
                    id
                    body
                }
            }
        GQL
    end
end