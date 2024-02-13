// swift-tools-version:5.5
import PackageDescription


let package = Package(
    name: "IJSVG",
    products: [.library(name: "IJSVG", targets: ["IJSVG"])],
    dependencies: [
        .package(url: "https://github.com/Archery-Inc/TouchXML.git", branch: "mutability")
    ],
    targets: [
        .target(
            name: "IJSVG",
            dependencies: [
                .product(name: "TouchXML", package: "TouchXML")
            ],
            path: "Sources",
            publicHeadersPath: "z-include", cSettings: [.headerSearchPath("z-include")]
        )
    ]
)
