import Foundation
import UIKit
import SnapKit
import SwiftUI

final class CuriosityViewController: UIViewController {
    let tabBarView = UIHostingController(
        rootView: TabBarView()
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        configure()
        configureTabBar(tabBarView)
    }

    private func configure() {
        setGradientBackground()
    }

    private func configureNavBar() {
        createCustomNavigationBar()

        let title = createCustomTitleView(contactName: "Категории")
        let profileButton = createCustomButton(image: VdohnovitelyAsset.profileIcon.image, selector: #selector(openProfile))
        let searchButton = createCustomButton(image: VdohnovitelyAsset.searchIcon.image, selector: #selector(searchCategory))

        navigationItem.rightBarButtonItems = [profileButton, searchButton]
        navigationItem.titleView = title
    }

    @objc func openProfile() {
        navigationController?.pushViewController(ProfileViewController(), animated: true)
    }

    @objc func searchCategory() {
        navigationController?.pushViewController(UIHostingController(rootView: ProfileView(model: .init(model: .stub))), animated: true)
    }
}
