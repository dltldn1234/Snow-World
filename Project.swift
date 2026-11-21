import ProjectDescription

let project = Project(
    name: "SnowWorld",
    options: .options(automaticSchemesOptions: .enabled()),
    targets: [
        .target(
            name: "SnowWorld",
            destinations: [.mac],
            product: .app,
            bundleId: "com.dltldn1234.snowworld",
            deploymentTargets: .macOS("13.0"),
            infoPlist: .file(path: "Config/Info.plist"),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            settings: .settings(
                base: [
                    "SWIFT_VERSION": "5.9",
                    "MACOSX_DEPLOYMENT_TARGET": "13.0",
                    "GENERATE_INFOPLIST_FILE": "NO",
                    "ENABLE_APP_SANDBOX": "YES",
                    "CODE_SIGN_ENTITLEMENTS": "Config/SnowWorld.entitlements",
                ]
            )
        )
    ]
)
