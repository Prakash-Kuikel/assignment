# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts, dependent: :destroy
  has_many :followings, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  devise :database_authenticatable,
         :registerable,
         #  :recoverable,
         #  :rememberable,
         #  :validatable,
         #  :trackable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenyList
end
