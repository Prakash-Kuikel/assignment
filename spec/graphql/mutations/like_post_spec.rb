# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::LikePost do
  let(:user) { create :user }
  let(:valid_user) { create :user, email: 'b@b', name: 'Sonam' }
  let(:valid_post) { valid_user.posts.create body: 'This is a valid post' }

  context 'with valid postId' do
    context 'if not liked already' do
      it 'returns true' do
        variable = {
          "postId": valid_post.id
        }
        response, errors = formatted_response(like_post_query, current_user: user, key: :likePost, variables: variable)

        expect(errors).to be_nil
        expect(response.to_h).to eq(true)
      end
    end

    context 'if already liked' do
      it 'raises error' do
        valid_post.likes.create user_id: user.id
        variable = {
          "postId": valid_post.id
        }
        response, errors = formatted_response(like_post_query, current_user: user, key: :likePost, variables: variable)

        expect(errors).to_not be_nil
      end
    end
  end

  context 'with invalid postId' do
    it 'raises error' do
      variable = {
        "postId": 123
      }
      response, errors = formatted_response(like_post_query, current_user: user, key: :likePost, variables: variable)

      expect(errors).to_not be_nil
    end
  end

  def like_post_query
    <<~GQL
      mutation ($postId: ID!){
        likePost(postId: $postId)
      }
    GQL
  end
end
