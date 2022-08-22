# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    sequence(:email) { |n| "user#{n}@gmail.com" }
    password { '123456' }
    password_confirmation { '123456' }
  end
end
