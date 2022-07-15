import Foundation
import UIKit

extension UIViewController {
    func createCustomNavigationBar() {
        navigationController?.navigationBar.barTintColor = .clear
    }

    func createCustomTitleView(contactName: String) -> UIView {
        let view = UIView()
        let nameLabel = UILabel()

        nameLabel.text = contactName
        nameLabel.font = UIFont.boldSystemFont(ofSize: 36)
        nameLabel.textColor = VdohnovitelyAsset.accentTextColor.color

        self.view.addSubview(nameLabel)

        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(45)
            make.left.equalToSuperview().inset(30)
        }

        return view
    }

    func createCustomButton(image: UIImage, selector: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .system)

        button.setImage(image, for: .normal)
        button.tintColor = .white

        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: selector, for: .touchUpInside)

        let menuBarItem = UIBarButtonItem(customView: button)
        return menuBarItem
    }
}

