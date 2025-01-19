// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "HelloWorldTopMenu",
    platforms: [
        .macOS(.v11)
    ],
    targets: [
        .executableTarget(
            name: "HelloWorldTopMenu",
            dependencies: [],
            path: "Sources/HelloWorldTopMenu"
        )
    ]
)