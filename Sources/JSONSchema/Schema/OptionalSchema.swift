/// JSONSchema for an optional value.
public struct OptionalSchema<ValueSchema: JSONSchema>: JSONSchema {
  public var type: String {
    wrapped.type
  }

  public var title: String? {
    get { wrapped.title }
    set { wrapped.title = newValue }
  }

  public var description: String? {
    get { wrapped.description }
    set { wrapped.description = newValue }
  }

  public var isRequired: Bool { false }

  public var wrapped: ValueSchema

  init(_ wrapped: ValueSchema) {
    self.wrapped = wrapped
  }

  public func encode(to encoder: any Encoder) throws {
    try wrapped.encode(to: encoder)
  }
}
