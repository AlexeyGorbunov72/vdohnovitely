import Foundation
import UIKit
import SnapKit
import SwiftUI

var dictAA: [Int: EditorViewController] = [
    0: EditorViewController(),
    1: EditorViewController(),
    2: EditorViewController(),
    3: EditorViewController(),
]

let modelCards = [
    GoalsCardModel(
        id: 0,
        name: "100 Отжиманий до 5 июля",
        createDate: "14.06",
        tasks: [
            GoalsTaskModel(
                id: 1,
                name: "10 отжиманий",
                deadLineDate: "19.06",
                taskTimeStatus: .completed,
                isCompleted: true
            ),
            GoalsTaskModel(
                id: 2,
                name: "30 отжиманий",
                deadLineDate: "3.07",
                taskTimeStatus: .overtimed,
                isCompleted: false
            ),
            GoalsTaskModel(
                id: 3,
                name: "40 отжиманий",
                deadLineDate: "4.07",
                taskTimeStatus: .closeToDeadline,
                isCompleted: false
            ),
            GoalsTaskModel(
                id: 4,
                name: "100 отжиманий",
                deadLineDate: "5.07",
                taskTimeStatus: .normal,
                isCompleted: false
            )
        ]
    ),
    GoalsCardModel(
        id: 1,
        name: "100 Отжиманий до 5 июля",
        createDate: nil,
        tasks: nil
    ),
    GoalsCardModel(
        id: 2,
        name: "100 Отжиманий до 5 июля",
        createDate: "14.06",
        tasks: [
            GoalsTaskModel(
                id: 1,
                name: "10 отжиманий",
                deadLineDate: "19.06",
                taskTimeStatus: .completed,
                isCompleted: true
            ),
            GoalsTaskModel(
                id: 2,
                name: "30 отжиманий",
                deadLineDate: "3.07",
                taskTimeStatus: .overtimed,
                isCompleted: false
            ),
            GoalsTaskModel(
                id: 3,
                name: "40 отжиманий",
                deadLineDate: "4.07",
                taskTimeStatus: .closeToDeadline,
                isCompleted: false
            ),
            GoalsTaskModel(
                id: 4,
                name: "100 отжиманий",
                deadLineDate: "5.07",
                taskTimeStatus: .normal,
                isCompleted: false
            )
        ]
    )
]

final class GoalsViewController: UIViewController {
    let goalsManager = GoalsManager.shared

    let tabBarView = UIHostingController(
        rootView: TabBarView()
    )

    let goalsScreen = UIHostingController(
        rootView: GoalsScreen(model: modelCards) // Передавать реальные данные
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()

        goalsManager.publisher
            .sink { event in
                switch event {
                case let .tapOnTask(taskId, _):
                    print("Zalupa\(taskId)")
//                    modelCards[cardID].tasks?[taskId - 1].isCompleted = !modelCards[cardID].tasks?[taskId - 1].isCompleted
                case let .tapOnCard(id):
                    dictAA[id]!.modalPresentationStyle = .fullScreen
                    self.navigationController?.present(dictAA[id]!, animated: true)
                }
            }
            .store(in: &disposable)


        configureNavBar()
        configure()
        configureTabBar(tabBarView)
    }

    private func configure() {
        setGradientBackground()

        add(goalsScreen)

        goalsScreen.view.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
        }

        goalsScreen.view.backgroundColor = .clear
    }

    private func configureNavBar() {
        createCustomNavigationBar()

        let title = createCustomTitleView(contactName: "Цели")
        let profileButton = createCustomButton(image: VdohnovitelyAsset.profileIcon.image, selector: #selector(openProfile))
        let addGoalButton = createCustomButton(image: VdohnovitelyAsset.addIcon.image, selector: #selector(addGoal))

        navigationItem.rightBarButtonItems = [profileButton, addGoalButton]
        navigationItem.titleView = title
    }

    @objc func openProfile() {
        navigationController?.pushViewController(ProfileViewController(), animated: true)
    }

    @objc func addGoal() {
        
    }
}
