import Arguments
import Primitives

enum Substitute: RunnableArgumentCommand {
    static let name = "substitute"

    static func components() throws -> [CommandComponentLowerable] {
        [
            about("Perform case-insensitive literal substitution while preserving matched capitalization."),
            arg(
                "inputs",
                as: String.self,
                arity: .variadic,
                help: "Strings in which to perform substitution."
            ),
            opt(
                "matching",
                as: String.self,
                default: "",
                help: "Literal substring to find, ignoring capitalization."
            ),
            opt(
                "replacement",
                as: String.self,
                default: "",
                help: "Replacement substring."
            ),
            flag(
                "first",
                help: "Replace only the first occurrence per input."
            ),
            flag(
                "json",
                short: "j",
                help: "Output the results as JSON."
            ),
        ]
    }

    static func run(_ invocation: ParsedInvocation) async throws {
        let matching = try invocation.value(
            "matching",
            as: String.self,
            default: ""
        )

        guard !matching.isEmpty else {
            throw ArgumentValidationError("A nonempty matching substring is required.")
        }

        let replacement = try invocation.value(
            "replacement",
            as: String.self,
            default: ""
        )

        let inputs = try invocation.values(
            "inputs",
            as: String.self
        )

        guard !inputs.isEmpty else {
            throw ArgumentValidationError("No inputs provided.")
        }

        let replacingAll = try !invocation.flag("first")

        let results = inputs.map { input in
            Case.substitute(
                input,
                matching: matching,
                with: replacement,
                replacingAll: replacingAll
            )
        }

        if try invocation.flag("json") {
            let output = JSONValue.object([
                "ok": .bool(true),
                "result": .array(results.map(JSONValue.string)),
            ])
            print(try output.toJSONString(prettyPrinted: true))
            return
        }

        for result in results {
            print(result)
        }
    }
}
