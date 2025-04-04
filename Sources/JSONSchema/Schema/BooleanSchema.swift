/// JSON schema for a boolean value.
public struct BooleanSchema: JSONSchema {
  public var type = "boolean"
  public var title: String?
  public var description: String?

  public init(title: String? = nil, description: String? = nil) {
    self.title = title
    self.description = description
  }
}
