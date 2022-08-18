# frozen_string_literal: true

require 'rails_helper'

describe Mutations::DeleteUser do
  let(:user) { create :user }

  context 'with correct old password' do
    it 'returns true' do
      variable = { "old_pwd": '123456' }
      response, errors = formatted_response(delete_user_query, current_user: user, key: :deleteUser, variables: variable)

      expect(errors).to be_nil
      expect(response.to_h).to eq(true)
    end
  end

  context 'with invalid old password' do
    it 'returns error' do
      variable = { "old_pwd": 'BAD-PWD' }
      response, errors = formatted_response(delete_user_query, current_user: user, key: :deleteUser, variables: variable)

      expect(errors).to_not be_nil
    end
  end
  def delete_user_query
    <<~GQL
      mutation($old_pwd: String!){
          deleteUser(oldPassword: $old_pwd)
      }
    GQL
  end
end