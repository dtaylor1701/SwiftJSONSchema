/// Some type which can be a JSON schema.
public protocol JSONSchema: Encodable {
  var type: String { get }
  var title: String? { get set }
  var description: String? { get set }

  var isRequired: Bool { get }
}

extension JSONSchema {
  public var isRequired: Bool { true }
}
