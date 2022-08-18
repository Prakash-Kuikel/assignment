require "rails_helper"

RSpec.describe "Feeds", type: :request do
    let(:current_user) { create :user }
    let(:user1) { create :user, name: "User1", email: "user1@gmail.com" }
    let(:user2) { create :user, name: "User2", email: "user2@gmail.com"}
    before do
        current_user.posts.create body: "This is post1 by CurrentUser"
        current_user.posts.create body: "This is post2 by CurrentUser"
        user1.posts.create body: "This is post1 by User1"
        user1.posts.create body: "This is post2 by User1"
        user2.posts.create body: "This is post1 by User2"
        user2.posts.create body: "This is post2 by User2"
        user2.posts.create body: "This is post3 by User2"        
    end
    context "while logged in" do
        before { sign_in current_user}
        it "displays other user's posts" do
            post graphql_path params: {query: feeds_query}

            expect(status).to eq(200)
            expect(response_body_json.data.feeds.map {|item| item["userId"]}).to include(String(user1.id) || String(user2.id))
        end
        it "doesn't display current user's posts" do
            post graphql_path params: {query: feeds_query}

            expect(response_body_json.data.feeds.map {|item| item["userId"]}).not_to include(String(current_user.id))
        end
    end
    context "while logged out" do
        it "gets redirected to sign_in" do
            post graphql_path params: {query: feeds_query}

            expect(status).to eq(302)
            expect(response.body).to include("You are being <a href=\"http://www.example.com/users/sign_in\">redirected")
        end
    end
end
 
def feeds_query
    <<~GQL
        {
            feeds{
                id
                body
                userId
                comments{
                    comment
                    userId
                }
            }
        }
    GQL
end