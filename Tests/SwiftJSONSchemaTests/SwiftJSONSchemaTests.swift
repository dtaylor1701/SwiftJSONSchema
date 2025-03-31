import Foundation
import SwiftJSONSchema
import Testing

@Test func example() async throws {
    let schemaJSON = try JSONEncoder().encode(TestObject.jsonSchema)
    let stringSchema = String(data: schemaJSON, encoding: .utf8)
    #expect(stringSchema == "")
}

struct TestObject: JSONSchemaObjectRepresentable {
    let name: String
    let nestedObject: NestedObject

    enum CodingKeys: String, CodingKey, CaseIterable {
        case name
        case nestedObject
    }

    static func propertyJSONSchema(forKey codingKey: CodingKeys) -> any SwiftJSONSchema.JSONSchema {
        switch codingKey {
        case .name: return StringSchema()
        case .nestedObject: return ObjectSchema<NestedObject>()
        }
    }
}

struct NestedObject: JSONSchemaObjectRepresentable {
    enum CodingKeys: String, CodingKey, CaseIterable {
        case value
    }
    let value: Double
    static func propertyJSONSchema(forKey codingKey: CodingKeys) -> any SwiftJSONSchema.JSONSchema {
        switch codingKey {
        case .value: schema(for: \.value)
        }
    }
}
