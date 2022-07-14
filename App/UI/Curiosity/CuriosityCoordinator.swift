import Foundation
import UIKit

final class CuriosityCoordinator: Coordinator<Never, Never> {

    override var container: UIViewController! { curiosityViewController }

    private var curiosityViewController: CuriosityViewController?

    override init() {
        super.init()
        start()
    }

    override func start() {
        let curiosityViewController = CuriosityViewController()
        self.curiosityViewController = curiosityViewController

        let item = UITabBarItem()
        item.image = UIImage(systemName: "square.and.arrow.down.fill")!
        curiosityViewController.tabBarItem = item
    }
}
