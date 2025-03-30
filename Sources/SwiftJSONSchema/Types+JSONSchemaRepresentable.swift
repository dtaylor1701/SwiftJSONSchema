extension Int: JSONSchemaRepresentable {
  public static var jsonSchema: any JSONSchema {
    IntegerSchema()
  }
}

extension Double: JSONSchemaRepresentable {
  public static var jsonSchema: any JSONSchema {
    NumberSchema()
  }
}

extension Float: JSONSchemaRepresentable {
  public static var jsonSchema: any JSONSchema {
    NumberSchema()
  }
}

extension Bool: JSONSchemaRepresentable {
  public static var jsonSchema: any JSONSchema {
    BooleanSchema()
  }
}

extension String: JSONSchemaRepresentable {
  public static var jsonSchema: any JSONSchema {
    StringSchema()
  }
}
