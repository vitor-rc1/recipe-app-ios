// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(
        productTypes: [:]
    )
#endif

let package = Package(
    name: "RecipeApp",
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.5.0"),
        .package(url: "https://github.com/WeTransfer/Mocker.git", from: "2.5.5"),
        .package(url: "https://github.com/SDWebImage/SDWebImage.git", from: "5.12.5"),
        .package(url: "https://github.com/faberNovel/SDWebImageMockPlugin.git", from: "0.1.0"),        
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.9.1"),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.9.0"),
    ]
)
