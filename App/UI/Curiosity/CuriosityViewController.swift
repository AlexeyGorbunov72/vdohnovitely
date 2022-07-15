import Foundation
import UIKit
import SnapKit
import SwiftUI

final class CuriosityViewController: UIViewController, CarouselViewProtocol {
    let tabBarView = UIHostingController(
        rootView: TabBarView()
    )

    lazy var carouselView = UIHostingController(
        rootView: CarouselContentView(delegate: self)
    )

    func showDetailView(category: CaregoryModel) {
        let detailViewController = UIHostingController(
            rootView: DetailCategoryContentView(category: category)
        )

        detailViewController.view.backgroundColor = .black
        self.present(detailViewController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        configure()
        configureTabBar(tabBarView)
    }

    private func configure() {
        setGradientBackground()
        configureCarouselView()
    }

    private func configureCarouselView() {
        add(carouselView)

        carouselView.view.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
        }

        carouselView.view.backgroundColor = .clear
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
