import ProjectDescription
import ProjectDescriptionHelpers

let moduleName = "App"

let dependecies: [TargetDependency] = [
    .external(name: "Alamofire"),
    .external(name: "SDWebImage"),
    .external(name: "Swinject"),
]

let testDependencies: [TargetDependency] = [
    .xctest,
    .target(name: moduleName),
    .external(name: "Mocker"),
    .external(name: "SDWebImageMockPlugin"),
    .external(name: "SnapshotTesting")
]

let packages: [Package] = [
    .remote(url: "https://github.com/SimplyDanny/SwiftLintPlugins.git",
                   requirement: .exact("0.62.2"))
]

let project = Project(
    name: moduleName,
    options: .options(automaticSchemesOptions: .disabled),
    packages: packages,
    targets: [
        .target(name: moduleName,
                destinations: .iOS,
                product: .app,
                bundleId: "com.vrc.recipes.\(moduleName.lowercased())",
                deploymentTargets: .iOS("18.0"),
                infoPlist: "Info.plist",
                sources: "Sources/**",
                resources: "Resources/**",
                scripts: [
                    .post(path: "../../scripts/swiftlint.sh", arguments: "", name: "Swiftlint")
                ],
                dependencies: dependecies
               ),
        .target(name: "\(moduleName)Tests",
                destinations: .iOS,
                product: .unitTests,
                bundleId: "com.vrc.recipes.\(moduleName.lowercased()).tests",
                deploymentTargets: .iOS("18.0"),
                infoPlist: .default,
                sources: ["Tests/**"],
                resources: "Tests/Helpers/JsonResponses/**",
                dependencies: testDependencies)
        
    ],
    schemes: [
        .scheme(name: moduleName,
                shared: true,
                buildAction: .buildAction(targets: [.project(path: ".", target: moduleName)]),
                testAction: .targets(["\(moduleName)Tests"]),
                runAction: .runAction(configuration: .debug,
                                      executable: .project(path: ".", target: moduleName),
                                      arguments: .arguments(environmentVariables: developmentEnv)))
    ]
)
