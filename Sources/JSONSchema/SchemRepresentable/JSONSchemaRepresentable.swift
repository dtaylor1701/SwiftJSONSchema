/// A type which can be represented as a JSON schema.
public protocol JSONSchemaRepresentable: Codable {
  associatedtype Schema: JSONSchema
  static var jsonSchema: Schema { get }
}
