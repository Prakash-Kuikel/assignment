# frozen_string_literal: true

def execute(query, current_user: nil, variables: nil)
  HashWithIndifferentAccess.new(
    MiniTwitterSchema.execute(query, context: { current_user: current_user }, variables: variables).as_json
  )
end

# For Queries
# When you pass a key, your expectation should read as
#   :=> user, errors = formatted_response.... where key: user
# Without the key it should read as
#   :=> data, errors = formatted_response...
#
# For Mutations
# You will mostly be passing the key, so your expectation can look like
#   :=> response, errors = formatted_response...
# where response will either be a boolean flag or an object based on what is returned
def formatted_response(query, current_user: nil, key: nil, variables: nil)
  response = execute(query, current_user: current_user, variables: variables)
  data = response[:data]
  [RecursiveOpenStruct.new(key ? data[key] : data), response[:errors]]
rescue StandardError => e
  ap e.message # for easier debugging during failures
end

def paginated_collection(node, query_string, current_user: nil, variables: nil)
  response = execute(query_string, current_user: current_user, variables: variables)
  [
    response.dig(:data, node, :edges)&.pluck(:node),
    response[:errors]
  ]
rescue StandardError
  error = response.dig(:errors, 0)

  ap case error.class
     when Hash
       error[:message]
     else
       error
     end
end

def graphql_response(klass, user, params = {})
  resolver = klass.new(field: nil, object: nil, context: { current_user: user })
  query(resolver, **params)
rescue Pundit::NotAuthorizedError
  [nil, [I18n.t('errors.pundit.message')]]
rescue StandardError => e
  record = e.try(:record)
  errors = record.try(:errors).present? ? record.errors.full_messages.to_sentence : e.message
  [nil, errors]
end

def query(resolver, **params)
  response = if resolver.class.include?(SearchObject::Base)
               params.empty? ? resolver.resolve_with_support : resolver.resolve_with_support(**params)
             else
               params.empty? ? resolver.resolve : resolver.resolve(**params)
             end
  [response, nil]
end
