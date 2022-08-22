# frozen_string_literal: true

def json
  RecursiveOpenStruct.new(
    HashWithIndifferentAccess.new(
      JSON.parse(response.body)
    )
  )
end

def response_header_json
  RecursiveOpenStruct.new(
    HashWithIndifferentAccess.new(
      response.header
    )
  )
end
