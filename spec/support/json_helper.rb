def json
    RecursiveOpenStruct.new(
      HashWithIndifferentAccess.new(
        JSON.parse(response.body)
      )
    )
end