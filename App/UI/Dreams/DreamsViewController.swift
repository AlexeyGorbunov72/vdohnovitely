import Foundation
import UIKit
import SnapKit
import SwiftUI

final class DreamsViewController: UIViewController {
    let dreamManager = DreamsManager.shared

    let tabBarView = UIHostingController(
        rootView: TabBarView()
    )

    let dreamScreen = UIHostingController(
      rootView: DreamScreen(model: [.stub, .stub2, .stub3, .stub, .stub, .stub])
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dreamManager.publisher
            .sink { event in
                switch event {
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

        add(dreamScreen)

        dreamScreen.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        dreamScreen.view.backgroundColor = .clear
    }
}
