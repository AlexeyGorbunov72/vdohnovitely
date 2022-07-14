import Foundation
import UIKit

final class GoalsCoordinator: Coordinator<Never, Never> {
    override var container: UIViewController! { goalsViewController }

    private var goalsViewController: GoalsViewController?

    override init() {
        super.init()
        start()
    }

    override func start() {
        let goalsViewController = GoalsViewController()
        self.goalsViewController = goalsViewController

        let item = UITabBarItem()
        item.image = UIImage(systemName: "square.and.arrow.down.fill")!
        goalsViewController.tabBarItem = item        
    }
}
