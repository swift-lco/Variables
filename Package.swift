// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "Variables",
    platforms: [
        .macOS(.v13),
    ],
    products: [
        .library(
            name: "Variables",
            targets: [
                "Variables",
            ]
        ),
        .executable(
            name: "casecon",
            targets: [
                "CaseCon",
            ]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-lco/Primitives.git",
            branch: "master"
        ),
        .package(
            url: "https://github.com/swift-lco/Arguments.git",
            branch: "master"
        ),
    ],
    targets: [
        .target(
            name: "Variables",
            dependencies: [
                "Primitives",
            ]
        ),
        .executableTarget(
            name: "CaseCon",
            dependencies: [
                "Arguments",
                "Primitives",
            ]
        ),
    ]
)
