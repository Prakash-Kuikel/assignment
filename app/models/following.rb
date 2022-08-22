# frozen_string_literal: true

class Following < ApplicationRecord
  belongs_to :user

  validates_associated :user
end
