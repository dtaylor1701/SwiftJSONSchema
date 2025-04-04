/// JSON schema for an integer value.
public struct IntegerSchema: JSONSchema {
  public var type = "integer"
  public var title: String?
  public var description: String?

  public init(title: String? = nil, description: String? = nil) {
    self.title = title
    self.description = description
  }
}
