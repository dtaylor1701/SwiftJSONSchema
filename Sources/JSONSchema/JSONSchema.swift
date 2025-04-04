public protocol JSONSchema: Encodable {
  var type: String { get }
  var title: String? { get set }
  var description: String? { get set }
}
