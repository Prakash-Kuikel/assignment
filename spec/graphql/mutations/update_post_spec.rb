# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::UpdatePost do
  let(:user) { create :user }
  let(:valid_post) do
    user.posts.create(body: 'This is a valid post')
  end

  context 'with valid postID' do
    let(:variable) do
      {
        post: {
          id: valid_post[:id],
          body: 'Updated body'
        }
      }
    end

    it 'returns true' do
      response, errors = formatted_response(update_post_query, current_user: user, key: :updatePost,
                                                               variables: variable)

      expect(errors).to be_nil
      expect(response.to_h).to be(true)
    end
  end

  context 'with invalid userID' do
    let(:variable) do
      {
        post: {
          id: 431,
          body: 'Updated body'
        }
      }
    end

    it 'returns error' do
      response, errors = formatted_response(update_post_query, current_user: user, key: :updatePost,
                                                               variables: variable)

      expect(errors).not_to be_nil
    end
  end

  def update_post_query
    <<~GQL
      mutation ($post: PostInputType!){
          updatePost(post: $post)
      }
    GQL
  end
end
