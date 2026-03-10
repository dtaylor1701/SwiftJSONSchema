# JSONSchema Product Manifesto

## Product Vision
To provide the Swift ecosystem with the most intuitive, type-safe, and idiomatic framework for bridge-building between Swift data models and the [JSON Schema](https://json-schema.org/) standard. We aim to eliminate the "double-definition" problem where developers must manually synchronize their Swift `Codable` models with external schema definitions.

## Core Objectives
*   **Single Source of Truth**: Leverage Swift's type system to automatically derive schemas from code.
*   **Compile-Time Safety**: Use Swift 6.0 features and KeyPaths to catch schema mismatches during development rather than at runtime.
*   **Zero-Overhead Integration**: Provide a "plug-and-play" experience for existing Swift projects using standard `Codable` patterns.
*   **Spec Compliance**: Maintain strict adherence to JSON Schema drafts while providing a modern Swift API.

## User Problem & Solution
**The Problem:** Modern applications often require JSON Schema for API documentation (OpenAPI), client-side validation, or dynamic form generation. Manually writing these schemas is error-prone, tedious, and quickly falls out of sync with the actual Swift implementation.

**The Solution:** `JSONSchema` allows developers to decorate their existing models with lightweight protocol conformances. The library then uses reflection and type metadata to generate 100% accurate schemas that are guaranteed to match the application's data structures.

---

## Target Audience & User Personas
1.  **Backend Swift Developers (Vapor/Hummingbird)**: Need to generate OpenAPI specifications or validate incoming JSON payloads against strict schemas.
2.  **Full-Stack Swift Engineers**: Developers using Swift on both the client and server who want shared validation logic.
3.  **Tooling Authors**: Developers building CMSs or form builders that need to programmatically describe data structures to frontend consumers.

---

## Feature Roadmap

### Short-Term (Foundation)
*   [x] Core support for primitive types (String, Int, Bool, Null).
*   [x] Basic Object and Array schema generation.
*   [x] Optionality handling via `OptionalSchema`.
*   [x] Integration with Swift's `CodingKeys`.

### Medium-Term (Validation & Metadata)
*   [ ] **Advanced Constraints**: Add support for `pattern` (regex), `minimum`/`maximum`, and `minLength`/`maxLength`.
*   [ ] **Schema Validation**: Implement a runtime validator to check JSON data against generated schemas.
*   [ ] **Reference Handling**: Support `$ref` for shared definitions to reduce schema size and complexity.
*   [ ] **Documentation Helpers**: Enhanced support for `examples` and `deprecated` tags.

### Long-Term (Ecosystem)
*   [ ] **OpenAPI 3.1 Export**: Direct export to OpenAPI components.
*   [ ] **Code Generation**: Reverse the flow—generate Swift `Codable` structs from existing JSON Schema files.
*   [ ] **Macro Support**: Utilize Swift Macros to further reduce the boilerplate required for `JSONSchemaObjectRepresentable` conformance.

---

## Feature Prioritization
We prioritize **Type Safety** and **Developer Experience (DX)** above all else. 
*   **Core Value:** A schema that compiles but produces invalid JSON is a failure. A schema that is hard to implement is a barrier to adoption.
*   **Selection Criteria:** We implement features based on their prevalence in the JSON Schema spec and their utility in common API development workflows.

---

## Iteration Strategy
Our development is shaped by two primary drivers:
1.  **The JSON Schema Specification**: As the standard evolves, our internal `Schema` models must follow.
2.  **Community Usage**: We monitor how developers conform complex nested models to identify friction points in the `JSONSchemaObjectRepresentable` protocol.
3.  **Dogfooding**: Using the library in production-grade API projects to identify performance bottlenecks in schema encoding.

---

## Release & Onboarding Strategy
*   **Semantic Versioning**: Strict adherence to SemVer to ensure stability for enterprise users.
*   **Documentation-First**: Every new schema type must be accompanied by usage examples in the README.
*   **Onboarding Goal**: A new user should be able to generate a schema for a standard `User` struct in under 5 minutes.

---

## Success Metrics (KPIs)
*   **Accuracy**: 100% pass rate against the official JSON Schema Test Suite for supported drafts.
*   **Performance**: Schema generation overhead should be <5% of standard `JSONEncoder` time.
*   **Adoption**: Growth in Swift Package Index downloads and GitHub stars.
*   **Developer Satisfaction**: Low issue-to-resolution time for "How-to" inquiries.

---

## Future Opportunities
*   **Cross-Platform Validation**: Using the same schema definitions to power validation in Swift-Wasm (Frontend) and Swift-Server (Backend).
*   **Visualizers**: Building a tool to visualize `JSONSchemaRepresentable` hierarchies directly within Xcode or a web preview.
