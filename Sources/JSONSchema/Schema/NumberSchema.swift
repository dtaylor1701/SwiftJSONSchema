/// JSON Schema for a number value.
public struct NumberSchema: JSONSchema {
  public var type: String? = "number"
  public var title: String?
  public var description: String?

  public var minimum: Double?
  public var maximum: Double?
  public var exclusiveMinimum: Double?
  public var exclusiveMaximum: Double?
  public var multipleOf: Double?

  public init(
    title: String? = nil,
    description: String? = nil,
    minimum: Double? = nil,
    maximum: Double? = nil,
    exclusiveMinimum: Double? = nil,
    exclusiveMaximum: Double? = nil,
    multipleOf: Double? = nil
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
