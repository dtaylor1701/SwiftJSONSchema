/// Type conformance for types which can be represented as a JSON schema.
public protocol JSONSchemaEnumRepresentable: CaseIterable, RawRepresentable, JSONSchemaRepresentable
{
}

extension JSONSchemaEnumRepresentable where RawValue: JSONSchemaRepresentable {
  public static var jsonSchema: some JSONSchema {
    EnumSchema<Self>()
  }
}
