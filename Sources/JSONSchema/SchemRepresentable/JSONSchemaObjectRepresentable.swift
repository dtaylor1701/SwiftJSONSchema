/// An object which can be represented as a JSON schema.
public protocol JSONSchemaObjectRepresentable: Encodable, JSONSchemaRepresentable {
  associatedtype CodingKeys: CodingKey & CaseIterable
  static func schema(forPropertyKey codingKey: CodingKeys) -> JSONSchema
}

extension JSONSchemaObjectRepresentable {
  public static var jsonSchema: some JSONSchema {
    ObjectSchema<Self>()
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
