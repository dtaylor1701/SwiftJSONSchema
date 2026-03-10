/// JSON Schema for an array of items.
public struct ArraySchema<ItemSchema: JSONSchema>: JSONSchema {
  public var type: String? = "array"
  public var title: String?
  public var description: String?
  public var itemSchema: ItemSchema
  
  public var minItems: Int?
  public var maxItems: Int?
  public var uniqueItems: Bool?

  enum CodingKeys: String, CodingKey {
    case type
    case itemSchema = "items"
    case title
    case description
    case minItems
    case maxItems
    case uniqueItems
  }

  public init(
    itemSchema: ItemSchema,
    title: String? = nil,
    description: String? = nil,
    minItems: Int? = nil,
    maxItems: Int? = nil,
    uniqueItems: Bool? = nil
  ) {
    self.itemSchema = itemSchema
    self.title = title
    self.description = description
    self.minItems = minItems
    self.maxItems = maxItems
    self.uniqueItems = uniqueItems
  }
}
