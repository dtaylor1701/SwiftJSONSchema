/// JSON schema for a string value.
public struct StringSchema: JSONSchema {
  public var type: String? = "string"
  public var title: String?
  public var description: String?

  public var minLength: Int?
  public var maxLength: Int?
  public var pattern: String?
  public var format: String?

  public init(
    title: String? = nil,
    description: String? = nil,
    minLength: Int? = nil,
    maxLength: Int? = nil,
    pattern: String? = nil,
    format: String? = nil
  ) {
    self.title = title
    self.description = description
    self.minLength = minLength
    self.maxLength = maxLength
    self.pattern = pattern
    self.format = format
  }
}
