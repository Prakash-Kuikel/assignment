require "rails_helper"

RSpec.describe "Following another user" do
    let(:current_user) { User.create(email: "a@a", name: "pk", password: "12345678", password_confirmation: "12345678") }
    let(:other_user) { User.create(email: "b@b", name: "Sonam", password: "123456", password_confirmation: "123456") }
    context "when user exists" do
        context "if not already following" do
            it "returns true" do
                variable = { "user_id": other_user.id }
                result = MiniTwitterSchema.execute(follow_query, variables: variable,
                                                                context: { current_user: current_user })

                expect(result.dig("data", "follow")).to eq(true)
            end
        end
        context "if already following" do
            it "returns error" do
                already_following
                variable = { "user_id": other_user.id }

                expect{ MiniTwitterSchema.execute(follow_query, variables: variable, 
                    context: { current_user: current_user }) }.to raise_error(ActiveRecord::RecordNotUnique)
            end
        end
        def already_following
            current_user.followings.create(following_id: other_user.id)
        end
    end

    context "when user doesn't exist" do
        it "returns error" do
            variable = { "user_id": 123 }

            expect{ MiniTwitterSchema.execute(follow_query, variables: variable, 
                context: { current_user: current_user }) }.to raise_error(ActiveRecord::InvalidForeignKey)
        end
    end

    def follow_query
        <<~GQL
            mutation($user_id: ID!){
              follow(userId: $user_id)
            }
        GQL
    end
end