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

extension Array: JSONSchemaRepresentable where Element: JSONSchemaRepresentable {
  public static var jsonSchema: some JSONSchema {
    ArraySchema(itemSchema: Element.jsonSchema)
  }
}
