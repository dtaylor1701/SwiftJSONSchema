I will read the `Package.swift` and core source files to understand the project's architecture and design patterns before generating the `DESIGN.md`.
I will examine `ObjectSchema.swift` and `OptionalSchema.swift` to better understand the schema composition and property management.
I will now examine `JSONSchemaObjectRepresentable.swift` to identify the requirements for object representation and complete my understanding of the design before generating the documentation.
I've analyzed the core components, architecture, and technical stack of the `JSONSchema` project. I'll now examine `JSONSchemaTests.swift` to understand the testing strategy before finalizing the `DESIGN.md`.
I've analyzed the `JSONSchema` project, its protocol-driven architecture, and its use of Swift 6.0 features. I'm now ready to draft the `DESIGN.md` file, highlighting its type-safe schema generation, declarative design, and robust testing strategy.

# JSONSchema Design Document

## 1. Introduction
JSONSchema is a Swift library designed to provide a type-safe, declarative, and extensible way to generate JSON Schema definitions directly from Swift types. By leveraging Swift's protocol-oriented programming and the `Codable` system, it ensures that your API's schema remains in sync with your data models.

## 2. Architecture & System Design
The architecture is built on two primary pillars: **Schema Definitions** and **Schema Representations**.

### 2.1. High-Level Architecture
- **Schema Layer**: Defines the structure of various JSON types (String, Integer, Object, etc.) according to the JSON Schema specification.
- **Representable Layer**: Provides protocols that Swift types can adopt to describe how they map to the Schema layer.
- **Encoding Layer**: Utilizes Swift's `Encodable` protocol to transform the internal schema structures into valid JSON Schema documents.

### 2.2. Design Philosophies
- **Type Safety**: Use Swift's type system to prevent invalid schema configurations at compile time.
- **Declarative Mapping**: Prefer declarative protocol conformance over imperative schema building.
- **Compositionality**: Build complex schemas by composing simpler ones (e.g., `OptionalSchema` wrapping a `StringSchema`).
- **Zero Dependencies**: Minimize external dependencies by relying on standard Swift libraries and the `Codable` framework.

## 3. Technical Stack
- **Language**: Swift 6.0+
- **Build System**: Swift Package Manager (SPM)
- **Serialization**: Foundation `JSONEncoder` (via `Encodable` protocol)
- **Testing**: Swift Testing framework

## 4. Data Models & Relationships

### 4.1. Core Protocols
- **`JSONSchema`**: The base protocol for all schema types. It requires common fields like `type`, `title`, and `description`.
- **`JSONSchemaRepresentable`**: A protocol for types that can be represented as a schema. It defines an `associatedtype Schema: JSONSchema`.
- **`JSONSchemaObjectRepresentable`**: A specialized protocol for Swift structs/classes. It requires `CodingKeys` to map properties to their respective schemas.

### 4.2. Schema Implementations
The library provides concrete implementations for all standard JSON Schema types:
- `StringSchema`, `IntegerSchema`, `NumberSchema`, `BooleanSchema`, `NullSchema`
- `ArraySchema`: Represents collections of types.
- `ObjectSchema`: Represents complex nested structures.
- `EnumSchema`: Represents a set of fixed values.
- `OptionalSchema`: Handles nullable/optional properties by wrapping other schemas.

## 5. Key Components & Interactions

### 5.1. Property Mapping
The `ObjectSchema` interacts with `JSONSchemaObjectRepresentable` to dynamically discover properties. It uses the `CodingKeys` of the Swift type to:
1. Iterate over all defined keys.
2. Query the type for the specific schema of each key.
3. Determine if a property is "required" based on the schema's `isRequired` property (e.g., `OptionalSchema` returns `false`).

### 5.2. Recursive Composition
Schemas can be nested. An `ObjectSchema` can contain properties that are themselves `ObjectSchema` or `ArraySchema` instances, allowing for the generation of deeply nested JSON structures.

## 6. Technical Specifications

### 6.1. Error Handling
The library relies on standard Swift error handling:
- **Encoding Errors**: Standard `EncodingError` may be thrown during the JSON generation process if custom encoding logic fails.
- **Static Validation**: Many potential errors (e.g., missing property mappings) are caught at compile time through protocol requirements.

### 6.2. Concurrency Model
The library is inherently thread-safe as it primarily uses immutable structs and stateless protocols. There is no shared global state or mutable singleton usage.

### 6.3. State Management
State is localized within the schema instances during the encoding lifecycle. Once a schema is generated, it is treated as a static representation of the type's structure.

## 7. Testing Infrastructure
The project uses the **Swift Testing** framework for its verification suite.

### 7.1. Testing Strategy
- **Unit Tests**: Verify that individual schema types (e.g., `StringSchema`) encode to the correct JSON format.
- **Integration Tests**: Ensure that complex Swift structures conforming to `JSONSchemaObjectRepresentable` generate complete and valid JSON Schema objects.
- **Protocol Verification**: Validate that the relationship between `JSONSchemaRepresentable` and its schema output is consistent.

## 8. Security, Scalability, & Performance

### 8.1. Performance
- **Minimal Overhead**: Schema generation is performed through standard `Codable` paths, making it as performant as regular JSON encoding.
- **Lazy Evaluation**: Schemas are typically generated on demand, minimizing memory footprint for unused types.

### 8.2. Scalability
The recursive nature of the design allows it to handle arbitrarily large and complex data models without a degradation in maintainability. New schema types can be added by simply implementing the `JSONSchema` protocol.

### 8.3. Security
By using a type-safe generation approach, the library reduces the risk of schema-injection attacks or malformed schema definitions that could lead to downstream validation bypasses in other systems.
