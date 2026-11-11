// swift-tools-version: 6.2

//
//  Package.swift
//  Wena
//
//  Created by Michelle Nathania on 11/11/26.
//

import PackageDescription

let package = Package(
    name: "WenaDesignSystem",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "WenaDesignSystem", targets: ["WenaDesignSystem"])
    ],
    targets: [
        .target(
            name: "WenaDesignSystem",
            resources: [
                .process("Resources/Assets.xcassets"),
                .copy("Resources/Fonts")
            ],
            swiftSettings: [.defaultIsolation(MainActor.self)]
        ),
        .testTarget(
            name: "WenaDesignSystemTests",
            dependencies: ["WenaDesignSystem"],
            swiftSettings: [.defaultIsolation(MainActor.self)]
        )
    ],
    swiftLanguageModes: [.v5]
)
