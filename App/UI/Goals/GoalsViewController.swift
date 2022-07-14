import Foundation
import UIKit
import SnapKit
import SwiftUI

final class GoalsViewController: UIViewController {
    let goalsManager = GoalsManager.shared

    let tabBarView = UIHostingController(
        rootView: TabBarView()
    )

    let goalsScreen = UIHostingController(
        rootView: GoalsScreen(model: [.stub2, .stub, .stub3]) // Передавать реальные данные
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()

        goalsManager.publisher
            .sink { event in
                switch event {
                case let .tapOnTask(id):
                    print("\(id)")
                case let .tapOnCard(id):
                    print("\(id)")
                }
            }
            .store(in: &disposable)

        configure()
        configureTabBar(tabBarView)
    }

    private func configure() {
        setGradientBackground()

        add(goalsScreen)

        goalsScreen.view.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.edges.equalToSuperview()
        }

        goalsScreen.view.backgroundColor = .clear
    }
}
