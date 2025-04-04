/// JSON Schema for an array of items.
public struct ArraySchema<ItemSchema: JSONSchema>: JSONSchema {
  public var type = "array"
  public var title: String?
  public var description: String?
  public var itemSchema: ItemSchema

  enum CodingKeys: String, CodingKey {
    case type
    case itemSchema = "items"
    case title
    case description
  }

  public init(itemSchema: ItemSchema, title: String? = nil, description: String? = nil) {
    self.itemSchema = itemSchema
    self.title = title
    self.description = description
  }
}
