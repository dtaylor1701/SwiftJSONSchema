/// JSON schema for a null type value.
public struct NullSchema: JSONSchema {
  public var type = "null"
  public var title: String?
  public var description: String?

  public init(title: String? = nil, description: String? = nil) {
    self.title = title
    self.description = description
  }
}
