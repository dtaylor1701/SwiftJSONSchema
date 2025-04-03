public protocol JSONSchemaRepresentable: Codable {
  associatedtype Schema: JSONSchema
  static var jsonSchema: Schema { get }
}
