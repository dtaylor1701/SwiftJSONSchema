public struct EnumSchema<Value: RawRepresentable & CaseIterable>: JSONSchema
where Value.RawValue: JSONSchemaRepresentable {
  public var type: String
  public var title: String?
  public var description: String?
  public var enumValues: [Value.RawValue]

  enum CodingKeys: String, CodingKey {
    case type
    case title
    case description
    case enumValues = "enum"
  }

  public init(title: String? = nil, description: String? = nil) {
    type = Value.RawValue.jsonSchema.type
    enumValues = Value.allCases.map { $0.rawValue }
    self.title = title
    self.description = description
  }
}
