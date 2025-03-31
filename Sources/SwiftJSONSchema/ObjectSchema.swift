public struct ObjectSchema<Object: JSONSchemaObjectRepresentable>: JSONSchema {
  public var type = "object"
  public var title: String?
  public var description: String?

  public init(title: String? = nil, description: String? = nil) {
    self.title = title
    self.description = description
  }

  enum CodingKeys: String, CodingKey {
    case type
    case properties
    case required
    case title
    case description
  }

  public func encode(to encoder: Encoder) throws {
    var container: KeyedEncodingContainer<ObjectSchema<Object>.CodingKeys> = encoder.container(
      keyedBy: CodingKeys.self)
    let properties = Properties<Object>()
    try container.encode(type, forKey: .type)
    try container.encodeIfPresent(title, forKey: .title)
    try container.encodeIfPresent(description, forKey: .description)
    try container.encode(properties, forKey: .properties)
    try container.encodeIfPresent(
      properties.requiredProperties, forKey: .required)
  }
}

public struct Properties<Object: JSONSchemaObjectRepresentable>: Encodable {
  var requiredProperties: [String]? {
    Object.requiredJSONSchemaKeys?.map(\.stringValue)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: Object.CodingKeys.self)
    for codingKey in Object.allJSONSchemaKeys {
      let schema = Object.propertyJSONSchema(forKey: codingKey)
      try container.encode(schema, forKey: codingKey)
    }
  }
}
