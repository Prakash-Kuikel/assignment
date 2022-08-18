require "rails_helper"

RSpec.describe "Current User", type: :request do
    let(:user) { create :user }
    
    context "when logged in" do
        before { sign_in user }
        it "returns current user details" do
            post graphql_path params: {query: current_user_query}
            
            expect(response_body_json.data.currentUser.name).to eq("John Cena")
            expect(response_body_json.data.currentUser.email).to eq("jc@gmail.com")
        end
    end

    context "when not logged in" do
        it "redirects to sign_in" do
            post graphql_path params: {query: current_user_query}

            expect(response.body).to include("You are being <a href=\"http://www.example.com/users/sign_in\">redirected")
        end
    end    
end

def current_user_query
    <<~GQL
        {
            currentUser{
                name
                email
            }
        }
    GQL
end