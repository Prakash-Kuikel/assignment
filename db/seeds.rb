# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.destroy_all

3.times do |i|
  User.create(email: "user#{i}@gmail.com", name: "User#{i}", password: "12345678", password_confirmation: "12345678")
end

3.times do |i|
  first_uid = User.first.id
  User.find(first_uid + i).posts.create(body: "This is a post of user#{first_uid + i}")
end

3.times do |i|
  first_pid = Post.first.id
  first_uid = User.first.id
  3.times do |j|
    Post.find(first_pid + i).comments.create(comment: "This is a comment by user#{first_uid + j}", user_id: (first_uid + j))
  end
end

