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


        configureNavBar()
        configure()
        configureTabBar(tabBarView)
    }

    private func configure() {
        setGradientBackground()

        add(goalsScreen)

        goalsScreen.view.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
        }

        goalsScreen.view.backgroundColor = .clear
    }

    private func configureNavBar() {
        createCustomNavigationBar()

        let title = createCustomTitleView(contactName: "Цели")
        let profileButton = createCustomButton(image: VdohnovitelyAsset.profileIcon.image, selector: #selector(openProfile))
        let addGoalButton = createCustomButton(image: VdohnovitelyAsset.addIcon.image, selector: #selector(addGoal))

        navigationItem.rightBarButtonItems = [profileButton, addGoalButton]
        navigationItem.titleView = title
    }

    @objc func openProfile() {
        navigationController?.pushViewController(ProfileViewController(), animated: true)
    }

    @objc func addGoal() {
        
    }
}
