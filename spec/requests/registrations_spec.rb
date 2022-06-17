require 'rails_helper'

RSpec.describe "RegistrationsController", type: :request do
    context "with matching password and confirmation" do
        it "returns status 200" do
            post user_registration_path, params: registration_params
            
            expect(status).to eq(200)
            expect(response_body_json.message).to eq("Signed up.")
            expect(response_body_json.user.email).to eq(registration_params[:user][:email])
            expect(response_body_json.user.name).to eq(registration_params[:user][:name])
        end
    end

    def registration_params
        {
            user: {
                email: "abc@gmail.com",
                name: "Prakash",
                password: "123456",
                password_confirmation: "123456"
            }
        }
    end
end
