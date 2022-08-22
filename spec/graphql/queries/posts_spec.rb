# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Resolver::Posts, type: :request do
  let_it_be(:user1) { create :user }
  let_it_be(:user2) { create :user }
  let_it_be(:user3) { create :user }
  let_it_be(:post1) { create :post, user: user1 }
  let_it_be(:post2) { create :post, user: user1 }
  let_it_be(:post3) { create :post, user: user2 }
  let_it_be(:post4) { create :post, user: user3 }
  let_it_be(:like) { create :like, post: post1, user: user2}
  let_it_be(:like) { create :like, post: post1, user: user3}
  let_it_be(:like) { create :like, post: post2, user: user2}
  let_it_be(:like) { create :like, post: post2, user: user3}
  let_it_be(:like) { create :like, post: post2, user: user1}
  let_it_be(:like) { create :like, post: post3, user: user1}

  describe 'with likes filter' do
    let(:args) { '{ likes: 2 }' }

    it 'returns posts with 2 likes' do
      post graphql_path params: { query: query(args) }
      expect(status).to eq(200)
      expect(to_i(json.data.posts)).to match_array([post1.id, post2.id])
    end
  end

  describe 'with created at filter' do
    let(:args) { '{ createdAt: "2022-08-19" }' }

    it 'returns posts created at given date' do
      post graphql_path params: { query: query(args) }
      expect(to_i(json.data.posts)).to match_array([post1.id, post2.id, post3.id, post4.id])
    end
  end

  describe 'with created_at and likes filter' do
    let(:args) { '{ likes: 2, createdAt: "2022-08-19" }' }

    it 'return posts with 2 likes and created at given date' do
      post graphql_path params: { query: query(args) }
      expect(to_i(json.data.posts)).to match_array([post1.id, post2.id])
    end
  end

  describe 'with no filter' do
    it 'returns all posts' do
      post graphql_path params: { query: query }
      expect(json.data.posts.count).to eq(4)
    end
  end

  def query(args = {})
    <<~GQL
      query {
         posts(params: #{args}) {
            id
            body
          }
       }
    GQL
  end
end

