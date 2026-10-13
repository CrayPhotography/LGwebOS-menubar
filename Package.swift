// swift-tools-version: 5.9
import PackageDescription
let package = Package(name: "LGRemote", platforms: [.macOS(.v14)], products: [.executable(name: "LGRemote", targets: ["LGRemote"])], targets: [.executableTarget(name: "LGRemote", resources: [.copy("registration.json"), .copy("AppAssets"), .copy("app-catalog.json")])])
