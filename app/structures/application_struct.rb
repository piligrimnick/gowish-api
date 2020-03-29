class ApplicationStruct < Dry::Struct
  transform_keys(&:to_sym)

  attribute :id, Types::Integer
end
