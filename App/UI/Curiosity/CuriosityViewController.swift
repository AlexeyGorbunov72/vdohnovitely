import Foundation
import UIKit
import SnapKit
import SwiftUI

final class CuriosityViewController: UIViewController {
    let tabBarView = UIHostingController(
        rootView: TabBarView()
    )

    let carouselView = UIHostingController(
        rootView: CarouselContentView()
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureTabBar(tabBarView)
    }

    private func configure() {
        setGradientBackground()

        add(carouselView)
        carouselView.view.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
        }

        carouselView.view.backgroundColor = .clear
    }
}
