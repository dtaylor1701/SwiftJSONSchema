public protocol JSONSchemaObjectRepresentable: Encodable, JSONSchemaRepresentable {
  associatedtype CodingKeys: CodingKey
  static var requiredJSONSchemaKeys: [CodingKeys]? { get }
  static var allJSONSchemaKeys: [CodingKeys] { get }
  static func propertyJSONSchema(forKey codingKey: CodingKeys) -> JSONSchema
}

extension JSONSchemaObjectRepresentable {
  public static var jsonSchema: JSONSchema {
    ObjectSchema<Self>()
  }
}

extension JSONSchemaObjectRepresentable where CodingKeys: CaseIterable {
  public static var allJSONSchemaKeys: [CodingKeys] {
    Array(CodingKeys.allCases)
  }

  public static var requiredJSONSchemaKeys: [CodingKeys]? {
    Array(CodingKeys.allCases)
  }
}

extension JSONSchemaObjectRepresentable {
  public static func schema<Property: JSONSchemaRepresentable>(
    for key: KeyPath<Self, Property>,
    title: String? = nil,
    description: String? = nil
  ) -> any JSONSchema {
    var schema = Property.jsonSchema
    schema.title = title
    schema.description = description
    return schema
  }
}
