/// A type-erased JSON schema.
public struct AnyJSONSchema: JSONSchema {
  public var type: String? { wrapped.type }
  
  public var title: String? {
    get { wrapped.title }
    set { wrapped.title = newValue }
  }
  
  public var description: String? {
    get { wrapped.description }
    set { wrapped.description = newValue }
  }
  
  public var isRequired: Bool { wrapped.isRequired }

  private var wrapped: any JSONSchema

  public init(_ schema: any JSONSchema) {
    self.wrapped = schema
  }

  public func encode(to encoder: Encoder) throws {
    try wrapped.encode(to: encoder)
  }
}
