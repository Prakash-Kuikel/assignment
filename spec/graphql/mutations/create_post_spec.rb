# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::CreatePost do
  let(:user) { create :user }

  context 'for logged in user' do
    let(:variable) do
      { post: { body: 'hello' } }
    end

    let(:expected_response) do
      { body: 'hello' }
    end

    it 'creates post and returns postID' do
      response, errors = formatted_response(query, current_user: user, variables: variable, key: :createPost)
      expect(errors).to be_nil
      expect(response.to_h).to eq(expected_response)
    end
  end

  def query
    <<~GQL
      mutation ($post: PostInputType!){
        createPost(post: $post){
          body
        }
      }
    GQL
  end
end
