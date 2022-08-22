# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Follow do
  let(:user) { create :user }
  let(:other_user) { create :user }

  before { sign_in(user) }

  context 'when user exists' do
    context 'if not already following' do
      it 'returns true' do
        variable = { user_id: other_user.id }
        response, errors = formatted_response(follow_query, current_user: user, key: :follow, variables: variable)

        expect(errors).to be_nil
        expect(response.to_h).to be(true)
      end
    end

    context 'if already following' do
      it 'returns error' do
        user.followings.create(following_id: other_user.id)

        variable = { user_id: other_user.id }
        response, errors = formatted_response(follow_query, current_user: user, key: :follow, variables: variable)
        expect(errors).not_to be_nil
      end
    end
  end

  context "when user doesn't exist" do
    it 'raises error' do
      variable = { user_id: 1234 }
      response, errors = formatted_response(follow_query, current_user: user, key: :follow, variables: variable)
      expect(errors).not_to be_nil
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
