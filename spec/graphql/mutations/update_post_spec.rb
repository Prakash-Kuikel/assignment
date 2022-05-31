require "rails_helper"

RSpec.describe "Updating Post" do

    let(:valid_post) do
        user = User.create(email: "a@a", name: "pk", password:"12345678", password_confirmation: "12345678")
        user.posts.create(body: "This is a valid post")
    end

    context "with valid postID" do
        it "returns true" do
            variable = {
                "post": {
                  "id":  valid_post[:id],
                  "body": "Updated body",
                }
            }
            result = MiniTwitterSchema.execute(update_post_query, variables: variable)
            
            expect(result.dig("data", "updatePost")).to eq(true)
        end
    end

    context "with invalid userID" do
        it "returns error" do
            variable = {
                "post": {
                  "id":  431,
                  "body": "Updated body",
                }
            }
            
            expect{ MiniTwitterSchema.execute(update_post_query, variables: variable) }.to raise_error(ActiveRecord::RecordNotFound)
        end
    end

    def update_post_query
        <<~GQL
            mutation ($post: postInputType!){
                updatePost(post: $post)
            }
        GQL
    end
end