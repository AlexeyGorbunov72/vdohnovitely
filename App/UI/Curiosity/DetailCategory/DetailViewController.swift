import UIKit
import SwiftUI

class DetailViewController: UIViewController {
    var category: CaregoryModel

    init(category: CaregoryModel) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {
        setGradientBackground()

        let detailViewController = UIHostingController(
            rootView: DetailCategoryContentView(category: category)
        )

        add(detailViewController)

        detailViewController.view.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
        }

        detailViewController.view.backgroundColor = .clear
    }
}
