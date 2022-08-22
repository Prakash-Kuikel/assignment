# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::CreateComment do
  let(:user) { create :user }
  let(:another_user) { create :user, email: 'b@b', name: 'Sonam' }
  let(:other_user_post) { another_user.posts.create body: 'This is a valid post' }

  context 'with valid postId' do
    let(:variable) do
       {
        "postId": other_user_post.id,
        "comment": 'This is a comment'
      }
    end

    let(:expected_response) do
      {
        comment: 'This is a comment',
        postId: other_user_post.id.to_s,
        userId: user.id.to_s
      }
    end

    it 'creates comment and returns commentID' do
      response, errors = formatted_response(query, current_user: user, variables: variable, key: :createComment)
      expect(errors).to be_nil
      expect(response.to_h).to eq(expected_response)
    end
  end

  context 'with invalid postId' do
    let(:variable) do
      {
        "postId": 123,
        "comment": 'This is a comment'
      }
    end

    it 'raises error' do
      response, errors = formatted_response(query, current_user: user, variables: variable, key: :createComment)
      expect(errors).to_not be_nil
    end
  end

  def query
    <<~GQL
      mutation ($postId: ID!, $comment: String!){
        createComment(postId: $postId, comment: $comment){
            comment
            userId
            postId
        }
      }
    GQL
  end
end
