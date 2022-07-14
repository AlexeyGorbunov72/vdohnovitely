import Foundation
import UIKit

final class DreamsCoordinator: Coordinator<Never, Never> {
    override var container: UIViewController! { dreamsViewController }

    private var dreamsViewController: DreamsViewController?

    override init() {
        super.init()
        start()
    }

    override func start() {
        let dreamsViewController = DreamsViewController()
        self.dreamsViewController = dreamsViewController

        let item = UITabBarItem()
        item.image = UIImage(systemName: "square.and.arrow.down.fill")!
        dreamsViewController.tabBarItem = item
    }
}
