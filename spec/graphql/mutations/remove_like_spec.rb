# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::RemoveLike do
  let(:user) { create :user }
  let(:valid_user) { create :user, email: 'b@b', name: 'Sonam' }
  let(:valid_post) { valid_user.posts.create body: 'This is a valid post' }

  context 'with valid postId' do
    let(:variable) do
      {
        postId: valid_post.id
      }
    end

    context 'if liked already' do
      it 'returns true' do
        valid_post.likes.create user_id: user.id

        response, errors = formatted_response(remove_like_query, current_user: user, key: :removeLike,
                                                                 variables: variable)

        expect(errors).to be_nil
        expect(response.to_h).to be(true)
      end
    end

    context 'if not already liked' do
      it 'raises error' do
        response, errors = formatted_response(remove_like_query, current_user: user, key: :removeLike,
                                                                 variables: variable)

        expect(errors).not_to be_nil
      end
    end
  end

  context 'with invalid postId' do
    it 'raises error' do
      variable = {
        postId: 123
      }
      response, errors = formatted_response(remove_like_query, current_user: user, key: :removeLike,
                                                               variables: variable)

      expect(errors).not_to be_nil
    end
  end

  def remove_like_query
    <<~GQL
      mutation ($postId: ID!){
        removeLike(postId: $postId)
      }
    GQL
  end
end
