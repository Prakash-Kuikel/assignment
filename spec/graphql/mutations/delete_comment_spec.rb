# frozen_string_literal: true

require 'rails_helper'

describe Mutations::DeleteComment do
  let(:user) { create :user }
  let(:valid_post) { user.posts.create body: 'This is a valid post' }
  let(:valid_comment) { valid_post.comments.create user_id: user.id, comment: 'This is a valid comment' }

  context 'with valid commentID' do
    it 'returns true' do
      variable = { "id": valid_comment[:id] }
      response, errors = formatted_response(delete_comment_query, current_user: user, variables: variable, key: :deleteComment)

      expect(errors).to be_nil
      expect(response.to_h).to eq(true)
    end
  end

  context 'with invalid commentID' do
    let(:variable){ { "id": 123 } }

    it 'returns error' do
      response, errors = formatted_response(delete_comment_query, current_user: user, variables: variable, key: :deleteComment)

      expect(errors).to_not be_nil
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
