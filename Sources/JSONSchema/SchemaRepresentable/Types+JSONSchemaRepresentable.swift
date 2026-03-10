import Foundation
extension Int: JSONSchemaRepresentable {
  public static var jsonSchema: some JSONSchema {
    IntegerSchema()
  }
}

extension Double: JSONSchemaRepresentable {
  public static var jsonSchema: some JSONSchema {
    NumberSchema()
  }
}

extension Float: JSONSchemaRepresentable {
  public static var jsonSchema: some JSONSchema {
    NumberSchema()
  }
}

extension Bool: JSONSchemaRepresentable {
  public static var jsonSchema: some JSONSchema {
    BooleanSchema()
  }
}

extension String: JSONSchemaRepresentable {
  public static var jsonSchema: some JSONSchema {
    StringSchema()
  }
}

extension URL: JSONSchemaRepresentable {
  public static var jsonSchema: some JSONSchema {
    StringSchema(format: "uri")
  }
}

extension UUID: JSONSchemaRepresentable {
  public static var jsonSchema: some JSONSchema {
    StringSchema(format: "uuid")
  }
}

extension Date: JSONSchemaRepresentable {
  public static var jsonSchema: some JSONSchema {
    StringSchema(format: "date-time")
  }
}

extension Array: JSONSchemaRepresentable where Element: JSONSchemaRepresentable {
  public static var jsonSchema: some JSONSchema {
    ArraySchema(itemSchema: Element.jsonSchema)
  }
}

extension Optional: JSONSchemaRepresentable where Wrapped: JSONSchemaRepresentable {
  public static var jsonSchema: some JSONSchema {
    OptionalSchema(Wrapped.jsonSchema)
  }
}
