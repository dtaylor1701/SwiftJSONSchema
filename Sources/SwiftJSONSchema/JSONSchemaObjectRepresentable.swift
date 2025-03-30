public protocol JSONSchemaObjectRepresentable: Encodable, JSONSchemaRepresentable {
  associatedtype JSONSchemaKeys: CodingKey
  static var requiredJSONSchemaKeys: [JSONSchemaKeys]? { get }
  static var allJSONSchemaKeys: [JSONSchemaKeys] { get }
  static func propertyJSONSchema(forKey codingKey: JSONSchemaKeys) -> JSONSchema
  static var jsonSchema: JSONSchema { get }
}

extension JSONSchemaObjectRepresentable {
  public static var jsonSchema: JSONSchema {
    ObjectSchema<Self>()
  }
}

extension JSONSchemaObjectRepresentable where JSONSchemaKeys: CaseIterable {
  public static var allJSONSchemaKeys: [JSONSchemaKeys] {
    Array(JSONSchemaKeys.allCases)
  }

  public static var requiredJSONSchemaKeys: [JSONSchemaKeys]? {
    Array(JSONSchemaKeys.allCases)
  }
}
