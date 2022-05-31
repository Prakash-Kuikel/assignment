require "rails_helper"

describe "Deleting user" do

    let(:valid_post) do
        user = User.create( email: "a@a", name: "pk", password:"123", password_confirmation: "123" )
        user.posts.create( body: "This is a valid post" )
    end

    context "with valid PostID" do
        it "returns true" do
            variable = { "id": valid_post[:id] }
            result = MiniTwitterSchema.execute(delete_post_query, variables: variable)
        
            expect(result.dig("data", "deletePost")).to eq(true)
        end
    end

    context "with invalid UserID" do
        it "returns error" do
            variable = { "id": 314 }

            expect{ MiniTwitterSchema.execute(delete_post_query, variables: variable) }.to raise_error(ActiveRecord::RecordNotFound)
        end
    end

    def delete_post_query 
        <<~GQL
            mutation ($id: ID!){
                deletePost(postId: $id)
            }
        GQL
    end
end