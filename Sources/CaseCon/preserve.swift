import Arguments
import Primitives

enum Preserve: RunnableArgumentCommand {
    static let name = "preserve"

    static func components() throws -> [CommandComponentLowerable] {
        [
            about("Apply an original string's capitalization or casing convention to a replacement."),
            opt(
                "original",
                as: String.self,
                default: "",
                help: "Original string whose casing should be preserved."
            ),
            opt(
                "replacement",
                as: String.self,
                default: "",
                help: "Replacement string."
            ),
            flag(
                "json",
                short: "j",
                help: "Output the result as JSON."
            ),
        ]
    }

    static func run(_ invocation: ParsedInvocation) async throws {
        let original = try invocation.value(
            "original",
            as: String.self,
            default: ""
        )

        guard !original.isEmpty else {
            throw ArgumentValidationError("An original string is required.")
        }

        let replacement = try invocation.value(
            "replacement",
            as: String.self,
            default: ""
        )

        let result = Case.preserve(
            original: original,
            replacement: replacement
        )

        if try invocation.flag("json") {
            let output = JSONValue.object([
                "ok": .bool(true),
                "result": .array([.string(result)]),
            ])
            print(try output.toJSONString(prettyPrinted: true))
            return
        }

        print(result)
    }
}
