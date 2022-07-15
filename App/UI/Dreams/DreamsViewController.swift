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

        configureNavBar()
        configure()
        configureTabBar(tabBarView)
    }

    private func configure() {
        setGradientBackground()

        add(dreamScreen)

        dreamScreen.view.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
        }

        dreamScreen.view.backgroundColor = .clear
    }

    private func configureNavBar() {
        createCustomNavigationBar()

        let title = createCustomTitleView(contactName: "Мечты")
        let profileButton = createCustomButton(image: VdohnovitelyAsset.profileIcon.image, selector: #selector(openProfile))
        let addDreamButton = createCustomButton(image: VdohnovitelyAsset.addIcon.image, selector: #selector(addDream))

        navigationItem.rightBarButtonItems = [profileButton, addDreamButton]
        navigationItem.titleView = title
    }

    @objc func openProfile() {
        navigationController?.pushViewController(ProfileViewController(), animated: true)
    }

    @objc func addDream() {
        
    }
}
