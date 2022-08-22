def to_i(record)
  record.pluck(:id).map(&:to_i)
end