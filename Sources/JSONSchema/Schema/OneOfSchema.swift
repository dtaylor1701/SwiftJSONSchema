/// JSON schema for "oneOf" composition.
public struct OneOfSchema: JSONSchema {
  public var type: String? { nil }
  public var title: String?
  public var description: String?
  public var schemas: [AnyJSONSchema]

  enum CodingKeys: String, CodingKey {
    case schemas = "oneOf"
    case title
    case description
  }

  public init(schemas: [any JSONSchema], title: String? = nil, description: String? = nil) {
    self.schemas = schemas.map { AnyJSONSchema($0) }
    self.title = title
    self.description = description
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(schemas, forKey: .schemas)
    try container.encodeIfPresent(title, forKey: .title)
    try container.encodeIfPresent(description, forKey: .description)
  }
}
