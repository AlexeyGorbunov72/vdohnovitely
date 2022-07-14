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
    private let tabBar = TabBar.shared

    private let curiosityCoordinator = CuriosityCoordinator()
    private let goalsCoordinator = GoalsCoordinator()
    private let dreamsCoordinator = DreamsCoordinator()

    private let navVC: UINavigationController = {
      let view = UINavigationController()
      view.isNavigationBarHidden = false
      return view
    }()

    init(window: UIWindow) {
        self.window = window
        super.init()

        window.rootViewController = navVC
        window.makeKeyAndVisible()

        navVC.setViewControllers([curiosityCoordinator.container], animated: false)

        tabBar.publisher
          .sink { [self] event in
            switch event {
            case .curiosity:
              navVC.setViewControllers([self.curiosityCoordinator.container], animated: false)
            case .dream:
              navVC.setViewControllers([self.dreamsCoordinator.container], animated: false)
            case .goal:
              navVC.setViewControllers([self.goalsCoordinator.container], animated: false)
            }
          }
          .store(in: &disposable)
    }
}
