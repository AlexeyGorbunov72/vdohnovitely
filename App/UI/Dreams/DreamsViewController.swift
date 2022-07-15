import Foundation
import UIKit
import SnapKit
import SwiftUI

let dreamsEditing = EditorViewController()

var dictA: [Int: EditorViewController] = [
    0: EditorViewController(),
    1: EditorViewController(),
    2: EditorViewController(),
    3: EditorViewController(),
]
final class DreamsViewController: UIViewController {
    let dreamManager = DreamsManager.shared

    let tabBarView = UIHostingController(
        rootView: TabBarView()
    )

    let dreamScreen = UIHostingController(
      rootView: DreamScreen(model: [.stub, .stub2, .stub3])
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dreamManager.publisher
            .sink { event in
                switch event {
                case let .tapOnCard(id):
                    dictA[id]!.modalPresentationStyle = .fullScreen
                    self.navigationController?.present(dictA[id]!, animated: true)
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
