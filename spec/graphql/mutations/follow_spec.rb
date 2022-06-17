require "rails_helper"

RSpec.describe "Following another user", type: :request do
    let(:user) { create :user }
    before { sign_in(user) }
    let(:other_user) { create :user, email: "b@b", name: "Sonam" }

    context "when user exists" do
        context "if not already following" do
            it "returns true" do
                variable = { "user_id": other_user.id }
                post graphql_path params: {query: follow_query, variables: variable}
                expect(response_body_json.data.follow).to eq(true)
            end
        end
        context "if already following" do
            it "returns error" do
                already_following
                variable = { "user_id": other_user.id }
                expect{ post graphql_path params: {query: follow_query, variables: variable} }.to raise_error(ActiveRecord::RecordNotUnique)
            end
        end
    end

    context "when user doesn't exist" do
        it "returns error" do
            variable = { "user_id": 123 }

            expect{ post graphql_path params: {query: follow_query, variables: variable} }.to raise_error(ActiveRecord::InvalidForeignKey)
        end
    end

    def already_following
        user.followings.create(following_id: other_user.id)
    end

    def follow_query
        <<~GQL
            mutation($user_id: ID!){
              follow(userId: $user_id)
            }
        GQL
    end
end
