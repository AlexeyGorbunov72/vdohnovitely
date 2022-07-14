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
        configure()
        configureTabBar(tabBarView)
    }

    private func configure() {
        view.backgroundColor = .yellow
    }
}
