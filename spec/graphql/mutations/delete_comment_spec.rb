# frozen_string_literal: true

require 'rails_helper'

describe Mutations::DeleteComment do
  let(:user) { create :user }
  let(:post) { create :post, user: user }
  let(:comment) { create :comment, post: post, user: user }

  context 'with valid commentID' do
    it 'returns true' do
      variable = { id: comment[:id] }
      response, errors = formatted_response(delete_comment_query, current_user: user, variables: variable,
                                                                  key: :deleteComment)

      expect(errors).to be_nil
      expect(response.to_h).to be(true)
    end
  end

  context 'with invalid commentID' do
    let(:variable) { { id: 123 } }

    it 'returns error' do
      response, errors = formatted_response(delete_comment_query, current_user: user, variables: variable,
                                                                  key: :deleteComment)

      expect(errors).not_to be_nil
    end
  end

  def delete_comment_query
    <<~GQL
      mutation ($id: ID!){
          deleteComment(commentId: $id)
      }
    GQL
  end
end
