# frozen_string_literal: true

module Resolver
  class PostsQuery < BaseQuery
    attr_accessor :likes, :created_at

    def call
      posts
        .then { |posts| fetch_by_likes(posts) }
        .then { |posts| fetch_by_created_at(posts) }
    end

    private

    def posts
      Post.all
    end

    def fetch_by_likes(posts)
      return posts if likes.blank?

      posts.where(id: Like.group(:post_id).having("count(*) > ?", 1).pluck(:post_id))
    end

    def fetch_by_created_at(posts)
      return posts if created_at.blank?

      posts.where("DATE(created_at) = ?", created_at)
    end
  end
end
