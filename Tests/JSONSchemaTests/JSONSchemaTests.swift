import Foundation
import JSONSchema
import Testing

@Test func testSchemaGeneration() async throws {
    let schemaJSON = try JSONEncoder().encode(TestObject.jsonSchema)
    let schemaObject = try JSONSerialization.jsonObject(with: schemaJSON) as? [String: Any]
    
    #expect(schemaObject != nil)
    #expect(schemaObject?["type"] as? String == "object")
    
    let required = schemaObject?["required"] as? [String]
    #expect(required?.contains("name") == true)
    #expect(required?.contains("nestedObject") == true)
    #expect(required?.contains("enumProperty") == true)
    #expect(required?.contains("optionalProperty") == false)
    
    let properties = schemaObject?["properties"] as? [String: Any]
    #expect(properties != nil)
    
    let nameSchema = properties?["name"] as? [String: Any]
    #expect(nameSchema?["type"] as? String == "string")
    
    let enumSchema = properties?["enumProperty"] as? [String: Any]
    #expect(enumSchema?["type"] as? String == "string")
    #expect(enumSchema?["enum"] as? [String] == ["one", "two", "three"])
    
    let nestedSchema = properties?["nestedObject"] as? [String: Any]
    #expect(nestedSchema?["type"] as? String == "object")
    #expect((nestedSchema?["required"] as? [String])?.contains("value") == true)
    
    let optionalSchema = properties?["optionalProperty"] as? [String: Any]
    #expect(optionalSchema?["type"] as? String == "integer")

    let urlSchema = properties?["url"] as? [String: Any]
    #expect(urlSchema?["type"] as? String == "string")
    #expect(urlSchema?["format"] as? String == "uri")

    let uuidSchema = properties?["uuid"] as? [String: Any]
    #expect(uuidSchema?["type"] as? String == "string")
    #expect(uuidSchema?["format"] as? String == "uuid")

    let dateSchema = properties?["date"] as? [String: Any]
    #expect(dateSchema?["type"] as? String == "string")
    #expect(dateSchema?["format"] as? String == "date-time")
}

@Test func testAnyJSONSchema() async throws {
    var schema = AnyJSONSchema(StringSchema(title: "Old Title"))
    schema.title = "New Title"
    
    let schemaJSON = try JSONEncoder().encode(schema)
    let schemaObject = try JSONSerialization.jsonObject(with: schemaJSON) as? [String: Any]
    
    #expect(schemaObject?["type"] as? String == "string")
    #expect(schemaObject?["title"] as? String == "New Title")
}

@Test func testOneOfSchema() async throws {
    let schema = OneOfSchema(schemas: [
        StringSchema(),
        IntegerSchema()
    ])
    
    let schemaJSON = try JSONEncoder().encode(schema)
    let schemaObject = try JSONSerialization.jsonObject(with: schemaJSON) as? [String: Any]
    
    #expect(schemaObject?["type"] == nil)
    let oneOf = schemaObject?["oneOf"] as? [[String: Any]]
    #expect(oneOf?.count == 2)
    #expect(oneOf?[0]["type"] as? String == "string")
    #expect(oneOf?[1]["type"] as? String == "integer")
}

struct TestObject: JSONSchemaObjectRepresentable {
    let name: String
    let enumProperty: TestEnum
    let nestedObject: NestedObject
    let optionalProperty: Int?
    let url: URL
    let uuid: UUID
    let date: Date

    enum CodingKeys: String, CodingKey, CaseIterable {
        case name
        case nestedObject
        case enumProperty
        case optionalProperty
        case url
        case uuid
        case date
    }

    static func schema(forPropertyKey codingKey: CodingKeys) -> any JSONSchema {
        switch codingKey {
        case .name: schema(for: \.name)
        case .nestedObject: schema(for: \.nestedObject)
        case .enumProperty: schema(for: \.enumProperty)
        case .optionalProperty: schema(for: \.optionalProperty)
        case .url: schema(for: \.url)
        case .uuid: schema(for: \.uuid)
        case .date: schema(for: \.date)
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
    static func schema(forPropertyKey codingKey: CodingKeys) -> any JSONSchema {
        switch codingKey {
        case .value: schema(for: \.value)
        }
    }
}
