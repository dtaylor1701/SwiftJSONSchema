public protocol JSONSchemaRepresentable {
  associatedtype Schema: JSONSchema
  static var jsonSchema: Schema { get }
}
