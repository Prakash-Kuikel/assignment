module Resolver
  class PostsQuery < BaseQuery
    attr_accessor :likes, :created_at

    def call
      posts
        .then { |posts| fetch_by_likes(posts) }
        .then { |posts| fetch_by_created_at(posts)}
    end

    private

    def posts
      Post.all
    end

    def fetch_by_likes(posts)
      return posts if likes.blank?

      posts.where(likes: likes)
    end

    def fetch_by_created_at(posts)
      return post if created_at.blank?

      posts.where(created_at: created_at)
    end
  end
end