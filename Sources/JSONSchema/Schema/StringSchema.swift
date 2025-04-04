/// JSON schema for a string value.
public struct StringSchema: JSONSchema {
  public var type = "string"
  public var title: String?
  public var description: String?

  public init(title: String? = nil, description: String? = nil) {
    self.title = title
    self.description = description
  }
}
