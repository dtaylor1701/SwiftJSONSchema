/// JSON schema for an integer value.
public struct IntegerSchema: JSONSchema {
  public var type: String? = "integer"
  public var title: String?
  public var description: String?

  public var minimum: Int?
  public var maximum: Int?
  public var exclusiveMinimum: Int?
  public var exclusiveMaximum: Int?
  public var multipleOf: Int?

  public init(
    title: String? = nil,
    description: String? = nil,
    minimum: Int? = nil,
    maximum: Int? = nil,
    exclusiveMinimum: Int? = nil,
    exclusiveMaximum: Int? = nil,
    multipleOf: Int? = nil
  ) {
    self.title = title
    self.description = description
    self.minimum = minimum
    self.maximum = maximum
    self.exclusiveMinimum = exclusiveMinimum
    self.exclusiveMaximum = exclusiveMaximum
    self.multipleOf = multipleOf
  }
}
