I will read `Package.swift` and the existing `README.md` to understand the project's configuration and current documentation state.
I will read `Sources/JSONSchema/Schema/JSONSchema.swift` and `Sources/JSONSchema/SchemRepresentable/JSONSchemaRepresentable.swift` to understand the core API and how to represent types as JSON schemas.
I will read `Sources/JSONSchema/Schema/ObjectSchema.swift` and `Sources/JSONSchema/SchemRepresentable/JSONSchemaObjectRepresentable.swift` to see how complex objects are handled.
I will read `Sources/JSONSchema/SchemRepresentable/Types+JSONSchemaRepresentable.swift` to understand the standard type support.
I will read `Tests/JSONSchemaTests/JSONSchemaTests.swift` to get a concrete usage example for the "Usage" section of the README.
# JSONSchema

A type-safe Swift library for generating [JSON Schema](https://json-schema.org/) definitions directly from your Swift models. By leveraging Swift's `Codable` and `KeyPath` systems, this package allows you to maintain a single source of truth for your data models and their corresponding JSON schemas.

## Features

- **Standard Type Support**: Built-in support for `String`, `Int`, `Double`, `Bool`, `Array`, and `Optional`.
- **Object Schemas**: Easily define schemas for complex structs and classes using `JSONSchemaObjectRepresentable`.
- **Enum Support**: Generate `enum` constraints in your schema using `JSONSchemaEnumRepresentable`.
- **Metadata**: Add `title` and `description` to any schema property.
- **Type-Safe**: Use Swift's `KeyPath` to ensure your schema definitions stay in sync with your property names and types.

## Installation

Add `JSONSchema` to your `Package.swift` dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/your-username/JSONSchema.git", from: "1.0.0")
]
```

Then, add it to your target's dependencies:

```swift
targets: [
    .target(
        name: "YourTarget",
        dependencies: ["JSONSchema"]
    )
]
```

## Usage

### 1. Simple Types

Standard Swift types already conform to `JSONSchemaRepresentable`. You can access their schema directly:

```swift
import JSONSchema

let intSchema = Int.jsonSchema
let stringSchema = String.jsonSchema
```

### 2. Defining Objects

To create a schema for a custom object, conform your type to `JSONSchemaObjectRepresentable`. You'll need to define your `CodingKeys` and implement the `schema(forPropertyKey:)` method.

```swift
import JSONSchema

struct User: JSONSchemaObjectRepresentable {
    let id: Int
    let name: String
    let email: String?
    let role: UserRole

    enum CodingKeys: String, CodingKey, CaseIterable {
        case id, name, email, role
    }

    static func schema(forPropertyKey codingKey: CodingKeys) -> any JSONSchema {
        switch codingKey {
        case .id: schema(for: \.id, title: "User ID")
        case .name: schema(for: \.name, description: "The full name of the user")
        case .email: schema(for: \.email)
        case .role: schema(for: \.role)
        }
    }
}

enum UserRole: String, JSONSchemaEnumRepresentable {
    case admin, member, guest
}
```

### 3. Generating the JSON

Once your types are defined, you can generate the JSON schema by encoding the `jsonSchema` property using a standard `JSONEncoder`.

```swift
import Foundation

let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted

if let schemaData = try? encoder.encode(User.jsonSchema),
   let schemaString = String(data: schemaData, encoding: .utf8) {
    print(schemaString)
}
```

## Project Structure

The project is organized into several key components:

- **Schema Definitions**: Located in `Sources/JSONSchema/Schema/`, these provide the underlying structures for different JSON types (Array, Boolean, Integer, Number, Object, String, etc.).
- **Representable Protocols**: Located in `Sources/JSONSchema/SchemRepresentable/`, these protocols (`JSONSchemaRepresentable`, `JSONSchemaObjectRepresentable`, `JSONSchemaEnumRepresentable`) allow your types to expose their schema structure.
- **Type Extensions**: Standard Swift types are extended to provide default schema implementations in `Types+JSONSchemaRepresentable.swift`.

## Dependencies

- **Swift 6.0+**: This package utilizes modern Swift features and requires Swift 6.0 or later.
- **No External Dependencies**: This package is lightweight and only depends on the Swift standard library and Foundation.

## License

[Add License Information Here]
