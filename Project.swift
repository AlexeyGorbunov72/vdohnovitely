import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

// MARK: - Project

let sceneDelegate: [String: InfoPlist.Value] = [
    "UIApplicationSceneManifest": .dictionary([
        "UIApplicationSupportsMultipleScenes": .boolean(false),
        "UISceneConfigurations": .dictionary([
            "UIWindowSceneSessionRoleApplication": .array([
                .dictionary([
                    "UISceneDelegateClassName": .string("$(PRODUCT_MODULE_NAME).SceneDelegate")
                ])
            ])
        ])
    ]),
    "Privacy - Camera Usage Description": .string("Нужно чтобы ты мог запечатлить свои мечты!")
]

let launchScreen: [String: InfoPlist.Value] = [
    "UILaunchScreen": .dictionary([
        "UIColorName": .string("stupidColor")
    ])
]

let extendedInfoPlistSettings = sceneDelegate.merging(launchScreen) { lhs, rhs in lhs }
let project = Project(
    name: "Вдохновители",
    organizationName: "dddddjalsdjakdw",
    targets: [
        Target(
            name: "Vdohnovitely",
            platform: .iOS,
            product: .app,
            bundleId: "vdohnovitely.ultimate.application",
            infoPlist: .extendingDefault(with: extendedInfoPlistSettings),
            sources: ["App/**"],
            resources: ["Resources/**"],
            dependencies: [
                .external(name: "SnapKit"),
                .external(name: "Alamofire")
//                ,
//                .external(name: "FirebaseAuth")
            ]
        )
    ]
)
