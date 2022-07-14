import Foundation
import UIKit
import SnapKit
import SwiftUI

final class CuriosityViewController: UIViewController {
    let tabBarView = UIHostingController(
        rootView: TabBarView()
    )

    let homeView = UIHostingController(
        rootView: Profile()
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureTabBar(tabBarView)
    }

    private func configure() {
        setGradientBackground()

        add(homeView)
        homeView.view.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
        }

        homeView.view.backgroundColor = .clear
    }
}



struct Profile: View {
    @State var text = ""
    @State var heightOfTextEditor: CGFloat = 20

    @State var achivments = [
        AchievementModel(id: 0),
        AchievementModel(id: 1),
        AchievementModel(id: 2),
        AchievementModel(id: 3),
        AchievementModel(id: 4),
        AchievementModel(id: 5),
        AchievementModel(id: 6),
        AchievementModel(id: 7),
        AchievementModel(id: 8),
        AchievementModel(id: 9),
        AchievementModel(id: 10)
    ]

    init() {
        UITextView.appearance().backgroundColor = .clear
    }

    var body: some View {

        VStack(alignment: .leading) {
            ZStack {
                Color(VdohnovitelyAsset.cardBackgroundColor.color)
                HStack(spacing: 30) {
                    Image(uiImage: VdohnovitelyAsset.cardImage.image)
                        .frame(width: 80, height: 80)
                        .cornerRadius(40)

                    VStack(alignment: .leading) {
                        Text("Дмитрий")
                            .foregroundColor(.white)
                        Divider()
                            .background(.white)
                        Text("Тарасов")
                            .foregroundColor(.white)
                    }
                }
                .padding([.leading], 20)
            }
            .frame(width: 368, height: 106)
            .cornerRadius(19)

            Text("О себе")
                .font(Font.headline)
                .foregroundColor(.white)

            TextEditor(text: $text)
                .frame(minWidth: 368, maxWidth: 368, minHeight: 20, maxHeight: 200)
                .background(Color(VdohnovitelyAsset.cardBackgroundColor.color))
                .foregroundColor(.white)
                .accentColor(.white)
                .cornerRadius(10)

            Text("Достижения")
                .font(Font.headline)
                .foregroundColor(.white)



            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(achivments) { element in
                        element.image
                            .frame(width: 50, height: 50)
                            .cornerRadius(25)
                    }
                }
            }
        }
        .padding([.leading, .trailing], 30)
    }
}


struct AchievementModel: Identifiable {
    let id: Int
    let image = Image(uiImage: VdohnovitelyAsset.cardImage.image)
}
