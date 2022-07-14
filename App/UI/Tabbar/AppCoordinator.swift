//
//  AppCoordinator.swift
//  MyApp
//
//  Created by Aleksei Gorbunov on 03.07.2022.
//  Copyright © 2022 MyOrg. All rights reserved.
//

import Foundation
import UIKit
import Combine
import SwiftUI

class AppCoordinator: NSObject {
    private let window: UIWindow
    private let tabbbar = UITabBarController()

    private let curiosityCoordinator = CuriosityCoordinator()
    private let goalsCoordinator = GoalsCoordinator()
    private let dreamsCoordinator = DreamsCoordinator()

    init(window: UIWindow) {
        self.window = window
        super.init()
        window.rootViewController = tabbbar

        tabbbar.viewControllers = [
            curiosityCoordinator.container,
            goalsCoordinator.container,
            dreamsCoordinator.container
        ]
        tabbbar.tabBar.backgroundColor = .brown
        window.makeKeyAndVisible()
    }
}
