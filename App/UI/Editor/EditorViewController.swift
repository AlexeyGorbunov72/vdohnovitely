import Foundation
import UIKit
import SwiftUI

final class EditorViewController: UIViewController {
    let swiftuiView = UIHostingController(rootView: EditorView())
    override func viewDidLoad() {
        super.viewDidLoad()

        add(swiftuiView)
        swiftuiView.view.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}
