# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::CreateComment do
  let(:user1) { create :user }
  let(:user2) { create :user }
  let(:post) { create :post, user: user2 }

  context 'with valid postId' do
    let(:variable) do
      {
        postId: post.id,
        comment: 'This is a comment'
      }
    end

    let(:expected_response) do
      {
        comment: 'This is a comment',
        userId: user1.id.to_s
      }
    end

    it 'creates comment and returns commentID' do
      response, errors = formatted_response(query, current_user: user1, variables: variable, key: :createComment)
      expect(errors).to be_nil
      expect(response.to_h).to eq(expected_response)
    end
  end

  context 'with invalid postId' do
    let(:variable) do
      {
        postId: 123,
        comment: 'This is a comment'
      }
    end

    it 'raises error' do
      response, errors = formatted_response(query, current_user: user1, variables: variable, key: :createComment)
      expect(errors).not_to be_nil
    end
  end

  def query
    <<~GQL
      mutation ($postId: ID!, $comment: String!){
        createComment(postId: $postId, comment: $comment){
            comment
            userId
        }
      }
    GQL
  end
end
