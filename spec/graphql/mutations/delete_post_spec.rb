# frozen_string_literal: true

require 'rails_helper'

describe Mutations::DeletePost do
  let(:user) { create :user }
  let(:post) { create :post, user: user}

  context 'with valid PostID' do
    it 'returns true' do
      variable = { id: post[:id] }

      response, errors = formatted_response(delete_post_query, current_user: user, variables: variable,
                                                               key: :deletePost)

      expect(errors).to be_nil
      expect(response.to_h).to be(true)
    end
  end

  context 'with invalid PostID' do
    it 'returns error' do
      variable = { id: 314 }

      response, errors = formatted_response(delete_post_query, current_user: user, variables: variable,
                                                               key: :deletePost)

      expect(errors).not_to be_nil
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
