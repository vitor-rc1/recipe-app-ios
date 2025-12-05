import ProjectDescription
import ProjectDescriptionHelpers

let moduleName = "DependencyInjection"

let dependecies: [TargetDependency] = [
    .external(name: "Swinject", condition: nil),
]

let project = Project.templateModule(named: moduleName,
                                     targets: [.source,. interfaces, .test],
                                     dependencies: dependecies)
