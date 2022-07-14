import Foundation
import UIKit
import SwiftUI
import SnapKit

extension UIViewController {
  func configureTabBar(_ tabBarView: UIHostingController<TabBarView>) {
    add(tabBarView)

    tabBarView.view.snp.makeConstraints { make in
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
      make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
      make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
    }

    tabBarView.view.backgroundColor = .clear
  }
}
