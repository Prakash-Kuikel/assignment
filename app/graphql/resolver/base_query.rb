# frozen_string_literal: true

module Resolver
  class BaseQuery
    include Assigner
    attr_accessor :current_user

    def initialize(current_user:, params: {})
      @current_user = current_user
      assign_attributes(params)
    end
  end
end
