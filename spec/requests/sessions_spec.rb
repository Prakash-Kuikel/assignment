# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'SessionsController', type: :request do
  let(:user) { create :user }
  before { user.save }

  context 'Logging in' do
    context 'with valid email and password' do
      it 'logs in successfully and returns JWT' do
        post '/users/sign_in', params: { user: { email: 'jc@gmail.com', password: '123456' } }

        expect(status).to eq(200)
        expect(response_body_json.message).to eq('Logged in successfully.')
        expect(response_header_json.Authorization).to be_present
      end
    end

    context 'with invalid credentials' do
      it 'raises error' do
        post '/users/sign_in', params: { user: { email: 'Bad@email', password: 'BAD' } }

        expect(status).to eq(401)
        expect(response_body_json.error).to eq('Invalid Email or password.')
        expect(response_header_json.Authorization).to be_blank
      end
    end
  end

  context 'Logging out' do
    context 'with valid JWT' do
      it 'logs out successfully' do
        post '/users/sign_in', params: { user: { email: 'jc@gmail.com', password: '123456' } }

        delete '/users/sign_out', headers: { "Authorization": response_header_json.Authorization }
        expect(status).to eq(200)
        expect(response_body_json.message).to eq('Logged out successfully.')
      end
    end
    context 'with invalid JWT' do
      it "doesn't log out" do
        post '/users/sign_in', params: { user: { email: 'jc@gmail.com', password: '123456' } }

        delete '/users/sign_out', headers: { "Authorization": 'BAD.JWT' }
        expect(status).to eq(401)
        expect(response_body_json.message).to eq('Log out failure.')
      end
    end
  end
end
