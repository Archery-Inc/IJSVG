// swift-tools-version:5.5
import PackageDescription


let package = Package(
    name: "IJSVG",
    products: [.library(name: "IJSVG", targets: ["IJSVG"])],
    targets: [
        .target(name: "IJSVG", path: "Sources", publicHeadersPath: "z-include", cSettings: [.headerSearchPath("z-include")])
    ]
)
