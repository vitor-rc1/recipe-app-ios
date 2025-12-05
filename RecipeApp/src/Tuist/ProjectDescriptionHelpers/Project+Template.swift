import ProjectDescription

public enum ModuleTargets: Equatable {
    case test, testing, interfaces, app, source
}
let mealBaseURL = EnvironmentVariable(stringLiteral: "https://www.themealdb.com/api/json/v1/1")
let drinkBaseURL = EnvironmentVariable(stringLiteral: "https://www.thecocktaildb.com/api/json/v1/1")

public let developmentEnv: [String: EnvironmentVariable] = [
    "MEAL_BASE_URL": mealBaseURL,
    "DRINK_BASE_URL": drinkBaseURL
]

public let iOSDeploymentTarget: DeploymentTargets = .iOS("18.0")

public extension Project {
    static func templateModule(named moduleName: String,
                               targets: [ModuleTargets] = [.source, .interfaces, .test],
                               dependencies: [TargetDependency] = [],
                               testDependencies: [TargetDependency] = [],
                               shouldSetEnvVars: Bool = false) -> Project {
        var selectedTargets: [Target] = []
        
        if targets.contains(.interfaces) {
            selectedTargets.append(
                .target(name: "\(moduleName)Interfaces",
                        destinations: .iOS,
                        product: .framework,
                        bundleId: "com.vrc.\(moduleName.lowercased()).interfaces",
                        deploymentTargets: iOSDeploymentTarget,
                        infoPlist: .default,
                        sources: ["Interfaces/**"])
            )
        }
        
        var moduleTargets: [TargetDependency] = dependencies
        
        if targets.contains(.interfaces) {
            moduleTargets.append(.target(name: "\(moduleName)Interfaces"))
        }
        
        if targets.contains(.source) {
            selectedTargets.append(
                .target(name: moduleName,
                        destinations: .iOS,
                        product: .framework,
                        bundleId: "com.vrc.\(moduleName.lowercased())",
                        deploymentTargets: iOSDeploymentTarget,
                        infoPlist: .default,
                        sources: ["Sources/**"],
                        dependencies: moduleTargets)
            )
        }
        
        if targets.contains(.test) {
            var testDeps: [TargetDependency] = testDependencies
            testDeps.append(.target(name: moduleName))
            
            if targets.contains(.testing) {
                testDeps.append(.target(name: "\(moduleName)Testing"))
            }
            
            selectedTargets.append(
                .target(name: "\(moduleName)Tests",
                        destinations: .iOS,
                        product: .unitTests,
                        bundleId: "com.vrc.\(moduleName.lowercased()).tests",
                        deploymentTargets: iOSDeploymentTarget,
                        infoPlist: .default,
                        sources: ["Tests/**"],
                        dependencies: testDeps)
            )
        }
        
        if targets.contains(.testing) && targets.contains(.interfaces) {
            selectedTargets.append(
                .target(name: "\(moduleName)Testing",
                        destinations: .iOS,
                        product: .framework,
                        bundleId: "com.vrc.\(moduleName.lowercased()).testing",
                        deploymentTargets: iOSDeploymentTarget,
                        infoPlist: .default,
                        sources: ["Testing/**"],
                        dependencies: [
                            .target(name: "\(moduleName)Interfaces")
                        ])
            )
        }
        
        return Project(
            name: moduleName,
            options: .options(automaticSchemesOptions: .disabled),
            targets: selectedTargets,
            schemes: [
                .scheme(
                    name: moduleName,
                    shared: true,
                    buildAction: .buildAction(targets: ["\(moduleName)"]),
                    testAction: targets.contains(.test) ? .targets(["\(moduleName)Tests"]) : nil,
                    runAction: .runAction(
                        configuration: .debug,
                        arguments: shouldSetEnvVars ? .arguments(environmentVariables: developmentEnv) : nil
                    )
                )
            ]
        )
    }
}
