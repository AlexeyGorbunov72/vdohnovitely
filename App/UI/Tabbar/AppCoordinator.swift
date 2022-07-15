import Foundation
import UIKit
import Combine
import SwiftUI
//import Firebase

protocol AuthorizationListener: AnyObject {

    func authorizationIsEnded()
}

class AppCoordinator: NSObject, AuthorizationListener {
    private let window: UIWindow
    private let tabBar = TabBar.shared

   // private var authView = AuthorizationView()
    private let curiosityCoordinator = CuriosityCoordinator()
    private let goalsCoordinator = GoalsCoordinator()
    private let dreamsCoordinator = DreamsCoordinator()

    private let navVC: UINavigationController = {
      let view = UINavigationController()
      
      return view
    }()

    func authorizationIsEnded() {
        window.rootViewController = navVC
        window.makeKeyAndVisible()
    }

    init(window: UIWindow) {
        self.window = window
        super.init()

//        showAuthorization(window: window)
        
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

// Не трогать, потом поправлю
//    private func showAuthorization(window: UIWindow) {
//        authView.delegate = self
//        window.rootViewController = UIHostingController(rootView: authView)
//    }

//    private func checkAuthorizationAndShowRequiredScreen(window: UIWindow) {
//        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
//            if user == nil {
//                window.rootViewController = UIHostingController(rootView: AuthorizationView())
//            } else {
//                window.rootViewController = self?.navVC
//            }
//        }
//    }
}
