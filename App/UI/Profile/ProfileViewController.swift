import Foundation
import UIKit
import SnapKit
import SwiftUI

final class ProfileViewController: UIViewController {

    let profileView = UIHostingController(
        rootView: ProfileView(model: .init(model: .stub)) // Передавать реальные данные
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.setHidesBackButton(true, animated: true)

        configureNavBar()
        configure()
    }

    private func configure() {
        setGradientBackground()

        add(profileView)

        profileView.view.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(-50)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
        }

        profileView.view.backgroundColor = .clear
    }

    private func configureNavBar() {
        createCustomNavigationBar()

        let title = createCustomTitleView(contactName: "Профиль")
        let exitButton = createCustomButton(image: VdohnovitelyAsset.exitIcon.image, selector: #selector(exit))
        let closeButton = createCustomButton(image: VdohnovitelyAsset.closeIcon.image, selector: #selector(back))

        navigationItem.rightBarButtonItems = [exitButton, closeButton]
        navigationItem.titleView = title
    }

    @objc func exit() {}

    @objc func back() {
        dismissMe(animated: true)
    }
}
