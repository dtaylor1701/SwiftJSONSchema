/// JSON schema for an object type.
public struct ObjectSchema<Object: JSONSchemaObjectRepresentable>: JSONSchema {
  public var type: String? = "object"
  public var title: String?
  public var description: String?
  
  public var minProperties: Int?
  public var maxProperties: Int?

  public init(
    title: String? = nil,
    description: String? = nil,
    minProperties: Int? = nil,
    maxProperties: Int? = nil
  ) {
    self.title = title
    self.description = description
    self.minProperties = minProperties
    self.maxProperties = maxProperties
  }

  enum CodingKeys: String, CodingKey {
    case type
    case properties
    case required
    case title
    case description
    case minProperties
    case maxProperties
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
    try container.encodeIfPresent(minProperties, forKey: .minProperties)
    try container.encodeIfPresent(maxProperties, forKey: .maxProperties)
  }
}

public struct Properties<Object: JSONSchemaObjectRepresentable>: Encodable {
  var requiredProperties: [String]? {
    let required = Object.CodingKeys.allCases.filter {
      Object.schema(forPropertyKey: $0).isRequired
    }.map(\.stringValue)
    return required.isEmpty ? nil : required
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: Object.CodingKeys.self)
    for codingKey in Object.CodingKeys.allCases {
      let schema = Object.schema(forPropertyKey: codingKey)
      try container.encode(schema, forKey: codingKey)
    }
  }
}
