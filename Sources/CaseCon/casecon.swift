import Arguments

@main
enum CaseCon: ArgumentCommand {
    static let name = "casecon"
    static let defaultChild = Convert.self

    static let children: [ArgumentCommandType] = [
        Convert.self,
        Preserve.self,
        Substitute.self,
    ]

    static func components() throws -> [CommandComponentLowerable] {
        [
            about(
                "Convert identifiers and perform case-preserving substitutions."
            ),
        ]
    }
}
