# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::UpdateUser do
  let(:user) { create :user }
  context 'with correct old password' do
    let(:variable) do
      {
        "old_pwd": '123456',
        "user": {
          "email": 'edited@gmail.com',
          "name": 'edited',
          "password": 'edited123',
          "passwordConfirmation": 'edited123'
        }
      }
    end
    it 'returns true' do
      response, errors = formatted_response(update_user_query, current_user: user, key: :updateUser, variables: variable)

      expect(errors).to be_nil
      expect(response.to_h).to eq(true)
    end
  end

  context 'with incorrect old password' do
    let(:variable) do
      {
        "old_pwd": 'BAD',
        "user": {
          "email": 'edited',
          "name": 'edited',
          "password": 'edited',
          "passwordConfirmation": 'edited'
        }
      }
    end
    it 'returns error' do
      response, errors = formatted_response(update_user_query, current_user: user, key: :updateUser, variables: variable)

      expect(errors).to_not be_nil
    end
  end

  def update_user_query
    <<~GQL
      mutation ($user: UserInputType!, $old_pwd: String!){
          updateUser(oldPassword: $old_pwd, newData: $user)
      }
    GQL
  end
end
