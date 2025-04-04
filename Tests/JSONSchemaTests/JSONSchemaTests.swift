import Foundation
import JSONSchema
import Testing

@Test func example() async throws {
    let schemaJSON = try JSONEncoder().encode(TestObject.jsonSchema)
    let stringSchema = String(data: schemaJSON, encoding: .utf8)
    #expect(stringSchema == "")
}

struct TestObject: JSONSchemaObjectRepresentable {
    let name: String
    let enumProperty: TestEnum
    let nestedObject: NestedObject

    enum CodingKeys: String, CodingKey, CaseIterable {
        case name
        case nestedObject
        case enumProperty
    }

    static func propertyJSONSchema(forKey codingKey: CodingKeys) -> any JSONSchema {
        switch codingKey {
        case .name: schema(for: \.name)
        case .nestedObject: schema(for: \.nestedObject)
        case .enumProperty: schema(for: \.enumProperty)
        }
    }
}

enum TestEnum: String, JSONSchemaEnumRepresentable {
    case one
    case two
    case three
}

struct NestedObject: JSONSchemaObjectRepresentable {
    enum CodingKeys: String, CodingKey, CaseIterable {
        case value
    }
    let value: Double
    static func propertyJSONSchema(forKey codingKey: CodingKeys) -> any JSONSchema {
        switch codingKey {
        case .value: schema(for: \.value)
        }
    }
}
